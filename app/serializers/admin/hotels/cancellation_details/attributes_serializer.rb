# frozen_string_literal: true

class Admin::Hotels::CancellationDetails::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :flg1, :flg2, :unit, :value, :updated_at
end
