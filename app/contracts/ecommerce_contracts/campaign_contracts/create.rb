# frozen_string_literal: true

class EcommerceContracts::CampaignContracts::Create < EcommerceContracts::CampaignContracts::Base
  validates :name, presence: true
  validates :ranking, numericality: { only_integer: true }, uniqueness: { model: Campaign }
end
