# == Schema Information
#
# Table name: campaign_products
#
#  id          :bigint           not null, primary key
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  campaign_id :bigint
#  product_id  :bigint
#
# Indexes
#
#  index_campaign_products_on_campaign_id  (campaign_id)
#  index_campaign_products_on_product_id   (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (campaign_id => campaigns.id)
#  fk_rails_...  (product_id => products.id)
#
class CampaignProduct < ApplicationRecord
  acts_as_paranoid

  belongs_to :product
  belongs_to :campaign
end
