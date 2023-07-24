# frozen_string_literal: true

class Api::V1::Tours::Indays::ReservationsController < ApiV1Controller
  def show
    tour = Api::TourOperations::IndayOperations::ReservationOperations::Show.new(actor, params).call
    render json:                   tour,
           serializer:             Api::Tours::Indays::Reservations::ShowSerializer,
           departure_date:         params[:departure_date],
           tour_start_location_id: params[:tour_start_location_id],
           total_person:           params[:total_person],
           root:                   'tours'
  end
end
