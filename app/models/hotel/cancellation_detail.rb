# == Schema Information
#
# Table name: hotel_cancellation_details
#
#  id                           :bigint           not null, primary key
#  deleted_at                   :datetime
#  flg1                         :bigint
#  flg2                         :bigint
#  name                         :string
#  unit                         :integer          default("percent")
#  value                        :float
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  hotel_cancellation_policy_id :bigint
#
# Indexes
#
#  hotel_cancellation_policy_index  (hotel_cancellation_policy_id)
#
# Foreign Keys
#
#  fk_rails_...  (hotel_cancellation_policy_id => hotel_cancellation_policies.id)
#
class Hotel::CancellationDetail < ApplicationRecord
  acts_as_paranoid

  belongs_to :hotel_cancellation_policy, foreign_key: :hotel_cancellation_policy_id,
                                         class_name:  'Hotel::CancellationPolicy'
  PRECENT = 'percent'.freeze
  JPY = 'jpy'.freeze
  enum unit: { percent: 1, jpy: 2 }

  def format_unit_jp
    case unit.to_s
    when 'percent'
      '%'
    when 'jpy'
      '円'
    else
      ''
    end
  end

  def format_value
    case unit.to_s
    when 'jpy'
      value.to_i
    else
      value
    end
  end
end
