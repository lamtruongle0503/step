# frozen_string_literal: true

class Api::V1::Users::ContactsController < ApiV1Controller
  before_action :authentication!

  def index
    user_contacts = Api::UserOperations::ContactOperations::Index.new(actor, params).call
    render json:            user_contacts,
           each_serializer: Api::Users::Contacts::IndexSerializer,
           root: 'data', adapter: :json
  end
end
