# frozen_string_literal: true

class Api::Hotels::CancellationDetails::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :flg1, :flg2, :value, :unit
end
