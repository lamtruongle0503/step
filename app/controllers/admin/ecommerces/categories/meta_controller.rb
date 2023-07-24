# frozen_string_literal: true

class Admin::Ecommerces::Categories::MetaController < ApiV1Controller
  before_action :authentication!

  def index
    categories = Admin::EcommerceOperations::CategoryOperations::MetaOperations::Index
                 .new(actor, params).call
    render json: categories, each_serializer: Admin::Ecommerces::Categories::Meta::IndexSerializer
  end
end
