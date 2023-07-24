# == Schema Information
#
# Table name: assets_modules
#
#  id          :bigint           not null, primary key
#  deleted_at  :datetime
#  module_type :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  asset_id    :bigint           not null
#  module_id   :bigint           not null
#
# Indexes
#
#  index_assets_modules_on_asset_id  (asset_id)
#  index_assets_modules_on_module    (module_type,module_id)
#
# Foreign Keys
#
#  fk_rails_...  (asset_id => assets.id)
#
class AssetsModule < ApplicationRecord
  acts_as_paranoid

  belongs_to :asset
  belongs_to :module, polymorphic: true
  belongs_to :user, foreign_key: :module_id, optional: true
  belongs_to :coupon, foreign_key: :module_id, optional: true
  belongs_to :tour, foreign_key: :module_id, optional: true
  belongs_to :campaign, foreign_key: :module_id, optional: true
  belongs_to :categories, foreign_key: :module_id, optional: true
  belongs_to :notification, foreign_key: :module_id, optional: true
  belongs_to :post, foreign_key: :module_id, optional: true
  belongs_to :hotel_room, foreign_key: :module_id, optional: true, class_name: 'Hotel::Room'
  belongs_to :hotel_meal, foreign_key: :module_id, optional: true, class_name: 'Hotel::Meal'
  belongs_to :hotel_option, foreign_key: :module_id, optional: true, class_name: 'Hotel::Option'
  belongs_to :tour_special_food, foreign_key: :module_id, optional: true, class_name: 'Tour::SpecialFood'
  belongs_to :tour_option, foreign_key: :module_id, optional: true, class_name: 'Tour::Option'
  belongs_to :life_support, foreign_key: :module_id, optional: true
  belongs_to :banner, foreign_key: :module_id, optional: true
end
