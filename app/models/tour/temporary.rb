# == Schema Information
#
# Table name: tour_temporaries
#
#  id                    :bigint           not null, primary key
#  address1              :string
#  address2              :string
#  birthday              :date
#  furigana              :string
#  gender                :integer
#  name                  :string
#  phone_number          :string
#  postal_code           :string
#  telephone             :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  tour_id               :bigint
#  tour_order_special_id :bigint
#
# Indexes
#
#  index_tour_temporaries_on_tour_id                (tour_id)
#  index_tour_temporaries_on_tour_order_special_id  (tour_order_special_id)
#
class Tour::Temporary < ApplicationRecord
  belongs_to :tour, class_name: 'Tour'
  enum gender: { male: 0, female: 1, other: 2 }
end
