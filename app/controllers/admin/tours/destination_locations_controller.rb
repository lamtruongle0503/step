# frozen_string_literal: true

class Admin::Tours::DestinationLocationsController < ApiV1Controller
  before_action :authentication!

  def index
    destinations = Admin::TourOperations::DestinationLocationOperations::Index.new(actor, params).call
    render json: destinations
  end
end
