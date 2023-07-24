# frozen_string_literal: true

class Admin::Tours::HostelsTours::AttributesSerializer < ApplicationSerializer
  attributes :id, :tour_hostel

  def tour_hostel
    Admin::Tours::Hostels::Tour::AttributesSerializer.new(object.tour_hostel).as_json
  end
end
