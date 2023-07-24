# frozen_string_literal: true

class Admin::Tours::HostelDepartures::AttributesSerializer < ApplicationSerializer
  attributes :id, :note, :option_ids, :tour_hostel

  def tour_hostel
    return unless object.tour_hostel

    Admin::Tours::Hostels::Tour::AttributesSerializer.new(object.tour_hostel).as_json
  end

  def option_ids
    return unless object.option_ids

    object.option_ids.map do |option_id|
      object.tour.tour_options.find_by(id: option_id)&.code
    end
  end
end
