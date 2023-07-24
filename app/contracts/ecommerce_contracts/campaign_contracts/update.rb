# frozen_string_literal: true

class EcommerceContracts::CampaignContracts::Update < EcommerceContracts::CampaignContracts::Base
  validates :name, presence: true, unless: -> { name.nil? }
end
