# frozen_string_literal: true

class Admin::Hotels::Plans::RoomSettingsController < ApiV1Controller
  before_action :authentication!

  def index
    room_settings = Admin::HotelOperations::PlanOperations::RoomSettingOperations::Index.new(actor,
                                                                                             params).call
    render json:            room_settings,
           each_serializer: Admin::Hotels::Plans::RoomSettings::IndexSerializer
  end
end
