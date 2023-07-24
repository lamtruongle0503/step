# frozen_string_literal: true

class EcommerceContracts::CategoryContracts::Base < ApplicationContract
  attribute :name,    String
  attribute :ranking, Integer
  attribute :code,    String

  validates :code, uniqueness: { model: Category }, if: -> { code.present? }
end
