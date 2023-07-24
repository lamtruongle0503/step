# frozen_string_literal: true

class Admin::Hotels::Childrens::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :code, :is_accept, :fee, :unit, :capacity, :created_at, :updated_at
end
