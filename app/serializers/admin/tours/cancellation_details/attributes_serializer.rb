# frozen_string_literal: true

class Admin::Tours::CancellationDetails::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :flg1, :flg2, :value
end
