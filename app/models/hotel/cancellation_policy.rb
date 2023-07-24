# == Schema Information
#
# Table name: hotel_cancellation_policies
#
#  id                     :bigint           not null, primary key
#  cxl_management_name    :string
#  date_free_cancellation :bigint
#  deleted_at             :datetime
#  is_use                 :boolean          default(FALSE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  hotel_id               :bigint
#
# Indexes
#
#  index_hotel_cancellation_policies_on_hotel_id  (hotel_id)
#
# Foreign Keys
#
#  fk_rails_...  (hotel_id => hotels.id)
#
class Hotel::CancellationPolicy < ApplicationRecord
  acts_as_paranoid

  belongs_to :hotel, foreign_key: :hotel_id
  has_many :hotel_cancellation_details, class_name: 'Hotel::CancellationDetail',
                                        foreign_key: :hotel_cancellation_policy_id, dependent: :destroy

  scope :use, -> { where(is_use: true) }
end
