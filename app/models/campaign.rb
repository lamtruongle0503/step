# == Schema Information
#
# Table name: campaigns
#
#  id          :bigint           not null, primary key
#  code        :string
#  deleted_at  :datetime
#  description :string
#  name        :string
#  ranking     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Campaign < ApplicationRecord
  acts_as_paranoid

  has_many :assets_modules, as: :module, dependent: :destroy
  has_many :assets, through: :assets_modules
  has_many :campaign_products
  has_many :products, through: :campaign_products, dependent: :destroy
end
