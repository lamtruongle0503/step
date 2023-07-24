# frozen_string_literal: true

class Api::Holidays::IndexSerializer < ApplicationSerializer
  attributes :id, :date, :holiday_name
end
