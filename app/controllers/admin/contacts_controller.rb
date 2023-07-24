# frozen_string_literal: true

class Admin::ContactsController < ApiV1Controller
  before_action :authentication!

  def index
    contacts = Admin::ContactOperations::Index.new(actor, params).call
    render json: contacts, each_serializer: Admin::Contacts::ShowSerializer,
           meta: pagination_dict(contacts), root: 'data', adapter: :json
  end

  def show
    render json: Admin::ContactOperations::Show.new(actor, params).call,
           serializer: Admin::Contacts::ShowSerializer, root: 'contacts'
  end

  def update
    render json: Admin::ContactOperations::Update.new(actor, params).call,
           serializer: Admin::Contacts::ShowSerializer, root: 'contacts'
  end

  def destroy
    render json: Admin::ContactOperations::Destroy.new(actor, params).call,
           serializer: Admin::Contacts::DestroySerializer, root: 'contacts'
  end

  def create
    render json: Admin::ContactOperations::Create.new(actor, params).call,
           serializer: Admin::Contacts::ShowSerializer, root: 'contacts'
  end
end
