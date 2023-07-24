# == Schema Information
#
# Table name: life_support_requests
#
#  id              :bigint           not null, primary key
#  address1        :string
#  address2        :string
#  name            :string
#  phone_number    :string
#  postal_code     :string
#  status          :integer          default("claim")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  life_support_id :bigint           not null
#  user_id         :bigint
#
# Indexes
#
#  index_life_support_requests_on_life_support_id  (life_support_id)
#  index_life_support_requests_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (life_support_id => life_supports.id)
#  fk_rails_...  (user_id => users.id)
#
class LifeSupport::Request < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :life_support

  enum status: { claim: 0, sent: 1 }

  ransacker :address1_or_address2 do
    Arel.sql "CONCAT(address1,'　',address2)"
  end
end
