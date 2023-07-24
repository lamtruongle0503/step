# frozen_string_literal: true

class Admin::Holidays::AttributesSerializer < ApplicationSerializer
  attributes :id, :holiday_name, :date
end
