# frozen_string_literal: true

class Admin::LifeSupportsController < ApiV1Controller
  before_action :authentication!

  def index
    life_supports = Admin::LifeSupportOperations::Index.new(actor, params).call
    render json:            life_supports,
           each_serializer: Admin::LifeSupports::IndexSerializer,
           meta: pagination_dict(life_supports), root: 'data', adapter: :json
  end

  def create
    Admin::LifeSupportOperations::Create.new(actor, params).call
    render json: {}
  end

  def show
    life_support = Admin::LifeSupportOperations::Show.new(actor, params).call
    render json: life_support, serializer: Admin::LifeSupports::ShowSerializer, root: 'data'
  end

  def destroy
    Admin::LifeSupportOperations::Destroy.new(actor, params).call
    render json: {}
  end

  def update
    Admin::LifeSupportOperations::Update.new(actor, params).call
    render json: {}
  end
end
