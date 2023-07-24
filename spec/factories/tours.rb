# frozen_string_literal: true

# == Schema Information
#
# Table name: tours
#
#  id                          :bigint           not null, primary key
#  code                        :string
#  deleted_at                  :datetime
#  destination                 :string
#  discount                    :integer
#  end_date                    :date
#  end_time                    :date
#  exp_point_bonus             :bigint
#  exp_point_receive           :bigint
#  first_row_seat_price        :bigint
#  hostel_list                 :integer
#  hotel_description           :string
#  info_travel_fee             :string
#  is_show_guide               :boolean          default(FALSE)
#  meal_description            :string
#  min_number_participant      :bigint
#  name                        :string
#  note                        :string
#  options                     :string
#  other_fee                   :string
#  plan_implement              :string
#  point_bonus_rate            :integer
#  point_receive_rate          :integer
#  regular_seat_price          :bigint
#  scheduler                   :string
#  sight_seeing                :string
#  start_date                  :date
#  start_time                  :date
#  status                      :integer          default("posted")
#  stayed_nights               :integer
#  stop_locations              :string
#  stopover                    :string
#  tax                         :integer
#  title                       :string
#  tour_guide                  :string
#  transport_used              :string
#  two_rows_seat_price         :float
#  type_locate                 :integer          default("inday")
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  company_staff_id            :bigint
#  tour_cancellation_policy_id :integer
#  tour_category_id            :bigint
#  tour_company_id             :bigint
#
# Indexes
#
#  index_tours_on_company_staff_id  (company_staff_id)
#  index_tours_on_tour_category_id  (tour_category_id)
#  index_tours_on_tour_company_id   (tour_company_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_staff_id => company_staffs.id)
#  fk_rails_...  (tour_category_id => tour_categories.id)
#
FactoryBot.define do
  factory :tour do
    name { Faker::Lorem.sentence(word_count: 3) }
    start_time { DateTime.current }
    end_time { DateTime.current + 1.day }
  end
end
