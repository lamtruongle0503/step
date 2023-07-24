# frozen_string_literal: true

class Admin::Hotels::Requests::AttributesSerializer < ApplicationSerializer
  attributes :id, :request_no, :full_name, :phone_number, :email, :check_in, :check_out, :total_person,
             :total_room, :room_type, :comments, :status
  belongs_to :hotel, serializer: Admin::Hotels::Meta::AttributesSerializer
  belongs_to :hotel_plan, serializer: Admin::Hotels::Plans::Meta::IndexSerializer
  belongs_to :hotel_room, serializer: Admin::Hotels::Rooms::Meta::IndexSerializer
end
