# frozen_string_literal: true

class Api::V1::Tours::Stays::InfoController < ApiV1Controller
  def show
    tour = Api::TourOperations::StayOperations::InfoOperations::Show.new(actor, params).call
    render json:              tour,
           serializer:        Api::Tours::Stays::Info::ShowSerializer,
           setting_date:      params[:departure_date],
           start_location_id: params[:start_location_id],
           root:              'data'
  end
end
