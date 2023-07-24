# frozen_string_literal: true

class Admin::Hotels::MetaController < ApiV1Controller
  before_action :authentication!

  def index
    hotels = Admin::HotelOperations::MetaOperations::Index.new(actor, params).call
    render json: hotels, each_serializer: Admin::Hotels::Meta::IndexSerializer
  end
end
