# frozen_string_literal: true

class Api::V1::Ecommerces::Categories::MetaController < ApiV1Controller
  before_action :authentication_ec!

  def index
    categories = Api::EcommerceOperations::CategoryOperations::MetaOperations::Index
                 .new(@actor_ec, params).call
    render json: categories, each_serializer: Admin::Ecommerces::Categories::Meta::IndexSerializer
  end
end
