# == Schema Information
#
# Table name: tour_special_foods
#
#  id         :bigint           not null, primary key
#  code       :string
#  deleted_at :datetime
#  is_free    :boolean          default(FALSE)
#  name       :string
#  price      :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tour_id    :bigint           not null
#
# Indexes
#
#  index_tour_special_foods_on_tour_id  (tour_id)
#
# Foreign Keys
#
#  fk_rails_...  (tour_id => tours.id)
#
class Tour::SpecialFood < ApplicationRecord
  belongs_to :tour, class_name: 'Tour', foreign_key: 'tour_id'
  has_many :assets_modules, as: :module, dependent: :destroy
  has_many :assets, through: :assets_modules, dependent: :destroy
  has_many :tour_order_accompanies, class_name: 'Tour::OrderAccompany', foreign_key: :tour_special_food_id
end
