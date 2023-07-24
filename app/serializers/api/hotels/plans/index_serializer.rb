# frozen_string_literal: true

class Api::Hotels::Plans::IndexSerializer < Api::Hotels::Plans::AttributesSerializer
  attr_reader :params, :in_stay, :to_night, :total_person, :number_children, :setting_children

  attributes :hotel_room

  def initialize(object, options = {})
    super
    @params = options[:params]
    @in_stay = params[:p][:date_check_in].to_date
    @to_night = params[:p][:to_night].to_i
    @total_person = params[:p][:total_person].to_i
    @setting_children = params[:q][:setting_children_eq].to_i
    @number_children = if setting_children == 1
                         params[:q][:hotel_rooms_number_children_gteq]
                       else
                         0
                       end
  end

  def hotel_room
    last_stay = in_stay + to_night
    object.hotel_rooms.includes(:assets)
          .show_room_plans(total_person, setting_children, number_children).uniq.map do |obj|
      hotel_room_settings = obj.hotel_room_settings.where(date:          in_stay...last_stay,
                                                          hotel_plan_id: object.id,
                                                          status:        Hotel::RoomSetting::OPEN)
                               .order('date ASC')
      next unless hotel_room_settings.present?

      object_rooms(obj, hotel_room_settings)
    end.compact
  end

  private

  def object_rooms(room, room_settings)
    price = sum_price_person_for_room(room_settings, in_stay, to_night, total_person)

    {
      id:               room.id,
      name:             room.name,
      description:      room.description,
      room_type:        room.room_type,
      square_meter_max: room.square_meter_max,
      square_meter_min: room.square_meter_min,
      capacity:         room.capacity,
      number_children:  room.number_children,
      price:            price,
      remain_room:      room_settings&.first&.remain_room,
      assets:           room.assets,
    }
  end
end
