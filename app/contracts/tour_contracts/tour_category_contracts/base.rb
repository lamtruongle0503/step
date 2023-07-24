# frozen_string_literal: true

class TourContracts::CategoryContracts::Base < ApplicationContract
  attribute :name,           String
  attribute :code,           String

  validates :name, presence: true
end
