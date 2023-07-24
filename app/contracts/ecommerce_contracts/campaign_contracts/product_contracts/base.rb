# frozen_string_literal: true

class EcommerceContracts::CampaignContracts::ProductContracts::Base < ApplicationContract
  attribute :product_id, Integer
  attribute :campaign_id, Integer
  validate :validate_product_campaign_uniqueness

  def validate_product_campaign_uniqueness
    return unless CampaignProduct.exists?(product_id: product_id, campaign_id: campaign_id)

    raise BadRequestError, product_id: I18n.t('models.exists')
  end
end
