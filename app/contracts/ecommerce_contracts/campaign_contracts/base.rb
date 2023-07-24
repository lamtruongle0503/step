# frozen_string_literal: true

class EcommerceContracts::CampaignContracts::Base < ApplicationContract
  attribute :name, String
  attribute :ranking, Integer
  attribute :code
  attribute :description, String

  validates :code, uniqueness: { model: Campaign }, if: -> { code.present? }
end
