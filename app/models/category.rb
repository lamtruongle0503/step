# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  code       :string
#  deleted_at :datetime
#  name       :string
#  ranking    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Category < ApplicationRecord
  acts_as_paranoid

  has_many :products, dependent: :destroy
  has_one :assets_module, as: :module, dependent: :destroy
  has_one :asset, through: :assets_module
end
