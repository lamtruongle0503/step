# frozen_string_literal: true

class Api::Tours::CancellationDetails::AttributesSerializer < ApplicationSerializer
  attributes :id, :flg1, :flg2, :name, :unit, :value
end
