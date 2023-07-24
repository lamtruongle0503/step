# frozen_string_literal: true

class Api::V1::Tours::Indays::InfoController < ApiV1Controller
  def show
    tour = Api::TourOperations::IndayOperations::InfoOperations::Show.new(actor, params).call
    render json:              tour,
           serializer:        Api::Tours::Indays::Info::ShowSerializer,
           start_location_id: params[:start_location_id],
           setting_date:      params[:departure_date],
           root:              'tours'
  end
end
