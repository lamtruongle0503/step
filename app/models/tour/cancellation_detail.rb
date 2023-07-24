# == Schema Information
#
# Table name: tour_cancellation_details
#
#  id                          :bigint           not null, primary key
#  flg1                        :bigint
#  flg2                        :bigint
#  name                        :string
#  unit                        :integer          default("percent")
#  value                       :float
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  tour_cancellation_policy_id :bigint
#
# Indexes
#
#  index_tour_cancellation_details_on_tour_cancellation_policy_id  (tour_cancellation_policy_id)
#
# Foreign Keys
#
#  fk_rails_...  (tour_cancellation_policy_id => tour_cancellation_policies.id)
#
class Tour::CancellationDetail < ApplicationRecord
  belongs_to :tour_cancellation_policy, foreign_key: 'tour_cancellation_policy_id',
                                        inverse_of:  :tour_cancellation_details,
                                        class_name:  'Tour::CancellationPolicy'

  PRECENT = 'percent'.freeze
  JPY = 'jpy'.freeze
  enum unit: { percent: 1, jpy: 2 }
end
