# == Schema Information
#
# Table name: tour_options
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
#  index_tour_options_on_tour_id  (tour_id)
#
# Foreign Keys
#
#  fk_rails_...  (tour_id => tours.id)
#
class Tour::Option < ApplicationRecord
  acts_as_paranoid
  belongs_to :tour
  has_many :tour_order_accompanies, class_name: 'Tour::OrderAccompany', foreign_key: :tour_option_id
  has_many :assets_modules, as: :module, dependent: :destroy
  has_many :assets, through: :assets_modules, dependent: :destroy
end
