# frozen_string_literal: true

class Admin::Tours::Hostels::Tour::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :note, :telephone
end
