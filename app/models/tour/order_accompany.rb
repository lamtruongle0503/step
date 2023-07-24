# == Schema Information
#
# Table name: tour_order_accompanies
#
#  id                       :bigint           not null, primary key
#  address1                 :string
#  address2                 :string
#  birth_day                :date
#  departure_start_location :string
#  depature_time            :string
#  email                    :string
#  first_name               :string
#  first_name_kana          :string
#  full_name                :string
#  furigana                 :string
#  gender                   :integer          default("female")
#  is_owner                 :boolean          default(FALSE)
#  is_save                  :boolean          default(FALSE)
#  is_user                  :boolean          default(FALSE)
#  last_name                :string
#  last_name_kana           :string
#  name_option              :jsonb
#  phone_number             :string
#  pickup_location          :integer
#  post_code                :string
#  price_food               :jsonb
#  room                     :string
#  selected_seat            :string
#  telephone                :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  tour_option_id           :bigint
#  tour_order_id            :bigint           not null
#  tour_special_food_id     :bigint
#
# Indexes
#
#  index_tour_order_accompanies_on_tour_option_id        (tour_option_id)
#  index_tour_order_accompanies_on_tour_order_id         (tour_order_id)
#  index_tour_order_accompanies_on_tour_special_food_id  (tour_special_food_id)
#
# Foreign Keys
#
#  fk_rails_...  (tour_order_id => tour_orders.id)
#
class Tour::OrderAccompany < ApplicationRecord
  belongs_to :tour_order, class_name: 'Tour::Order', foreign_key: 'tour_order_id'
  belongs_to :tour_special_food, optional: true, class_name: 'Tour::SpecialFood',
                                 foreign_key: 'tour_special_food_id'
  belongs_to :tour_option, optional: true, class_name: 'Tour::Option', foreign_key: 'tour_option_id'

  FEMALE = 'female'.freeze
  MALE = 'male'.freeze
  OTHER = 'other'.freeze
  enum gender: { female: 0, male: 1, other: 2 }

  def age
    return nil unless birth_day

    today = Time.zone.now.to_date
    age = today.year - birth_day.year
    age - (today < (birth_day + age.year) ? 1 : 0)
  end
end
