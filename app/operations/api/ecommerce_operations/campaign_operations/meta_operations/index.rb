# frozen_string_literal: true

class Api::EcommerceOperations::CampaignOperations::MetaOperations::Index < ApplicationOperation
  def call
    Campaign.all
  end
end
