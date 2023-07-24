# == Schema Information
#
# Table name: tour_informations
#
#  id                        :bigint           not null, primary key
#  adult_dayoff_amount       :float
#  adult_dayoff_discount     :bigint
#  adult_dayoff_price        :float
#  adult_weekday_amount      :float
#  adult_weekday_discount    :bigint
#  adult_weekday_price       :float
#  baby_dayoff_amount        :float
#  baby_dayoff_discount      :bigint
#  baby_dayoff_price         :float
#  baby_weekday_amount       :float
#  baby_weekday_discount     :bigint
#  baby_weekday_price        :float
#  children_dayoff_amount    :float
#  children_dayoff_discount  :bigint
#  children_dayoff_price     :float
#  children_weekday_amount   :float
#  children_weekday_discount :bigint
#  children_weekday_price    :float
#  max_price                 :float
#  min_price                 :float
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  tour_id                   :bigint           not null
#
# Indexes
#
#  index_tour_informations_on_tour_id  (tour_id)
#
# Foreign Keys
#
#  fk_rails_...  (tour_id => tours.id)
#
class Tour::Information < ApplicationRecord
  self.table_name = 'tour_informations'

  belongs_to :tour, class_name: 'Tour', foreign_key: 'tour_id'
end
