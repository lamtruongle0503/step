# frozen_string_literal: true

class Admin::Hotels::Childrens::Meta::IndexSerializer < ApplicationSerializer
  attributes :id, :hotel_id, :name, :is_accept, :capacity
end
