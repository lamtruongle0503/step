# frozen_string_literal: true

class Admin::Contacts::CategoriesController < ApiV1Controller
  before_action :authentication!

  def index
    render json:            Admin::ContactOperations::CategoryOperations::Index.new(actor, params).call,
           each_serializer: Admin::Contacts::Categories::IndexSerializer
  end
end
