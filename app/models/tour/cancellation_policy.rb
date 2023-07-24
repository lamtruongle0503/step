# == Schema Information
#
# Table name: tour_cancellation_policies
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tour::CancellationPolicy < ApplicationRecord
  has_many :tour_cancellation_details, foreign_key: 'tour_cancellation_policy_id', dependent: :destroy,
class_name: 'Tour::CancellationDetail', inverse_of: :tour_cancellation_policy
  has_many :tours, foreign_key: 'tour_cancellation_policy_id', dependent: :destroy, class_name: 'Tour'
  accepts_nested_attributes_for :tour_cancellation_details, allow_destroy: true
end
