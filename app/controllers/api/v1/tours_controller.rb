# frozen_string_literal: true

class Api::V1::ToursController < ApiV1Controller
  # before_action :authentication!

  def index
    render json:            Api::TourOperations::Index.new(nil, params).call,
           each_serializer: Api::Tours::IndexSerializer
  end

  def show
    render json:       Api::TourOperations::Show.new(nil, params).call,
           serializer: Api::Tours::ShowSerializer
  end
end
