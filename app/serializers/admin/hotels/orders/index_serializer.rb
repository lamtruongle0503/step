# frozen_string_literal: true

class Admin::Hotels::Orders::IndexSerializer < Admin::Hotels::Orders::AttributesSerializer
  attributes :total_room, :person_each_room

  def person_each_room
    object.person_total / object.total_room
  end
end
