class CreateCampaignProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :campaign_products do |t|
      t.belongs_to :campaign, foreign_key: true, index: true
      t.belongs_to :product, foreign_key: true, index: true

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
