# frozen_string_literal: true

class Admin::Tours::Managements::ManagementFiles::AttributesSerializer < ApplicationSerializer
  attributes :id, :bus_no, :departure_location, :number_of_people, :capacity
end
