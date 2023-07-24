# frozen_string_literal: true

class Api::Tours::Stays::Hostels::AttributeSerializer < ApplicationSerializer
  attributes :id, :name, :address1, :address2, :description, :telephone, :postal_code
end
