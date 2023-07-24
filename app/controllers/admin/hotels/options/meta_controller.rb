# frozen_string_literal: true

class Admin::Hotels::Options::MetaController < ApiV1Controller
  before_action :authentication!

  def index
    hotel_options = Admin::HotelOperations::OptionOperations::MetaOperations::Index.new(actor, params).call
    render json: hotel_options,
           each_serializer: Admin::Hotels::Options::ShowSerializer,
           root: 'data', adapter: :json
  end
end
