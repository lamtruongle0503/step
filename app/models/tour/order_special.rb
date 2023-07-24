# == Schema Information
#
# Table name: tour_order_specials
#
#  id               :bigint           not null, primary key
#  capacity_pattern :string
#  code             :string
#  description      :string
#  name             :string
#  number_of_people :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  tour_id          :bigint
#
# Indexes
#
#  index_tour_order_specials_on_tour_id  (tour_id)
#
# Foreign Keys
#
#  fk_rails_...  (tour_id => tours.id)
#
class Tour::OrderSpecial < ApplicationRecord
  FULL_PLACE  = 'full_place'.freeze
  TEMPORARI   = 'temporari'.freeze
  CXL         = 'cxl'.freeze
  CXL_WAITING = 'cxl_waiting'.freeze
  SPECIAL     = %w[full_place temporari cxl cxl_waiting].freeze

  belongs_to :tour, class_name: Tour.name, foreign_key: :tour_id
  has_many :tour_temporaries, class_name: Tour::Temporary.name, foreign_key: :tour_order_special_id,
           dependent: :destroy
end
