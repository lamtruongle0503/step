# frozen_string_literal: true

class Admin::Tours::StartLocations::Meta::IndexSerializer < ApplicationSerializer
  attributes :id, :name, :address, :code
end
