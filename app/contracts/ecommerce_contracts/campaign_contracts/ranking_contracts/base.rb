# frozen_string_literal: true

class EcommerceContracts::CampaignContracts::RankingContracts::Base < ApplicationContract
  attribute :campaign_attributes, Array

  validates :campaign_attributes, presence: true

  validate :ranking_uniqueness

  def ranking_uniqueness
    return if campaign_attributes.pluck('ranking').uniq?

    errors.add :ranking, I18n.t('campaigns.ranking_must_unique')
  end
end
