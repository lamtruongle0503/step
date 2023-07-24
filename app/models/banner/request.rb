# == Schema Information
#
# Table name: banner_requests
#
#  id           :bigint           not null, primary key
#  address1     :string
#  address2     :string
#  name         :string
#  phone_number :string
#  postal_code  :string
#  status       :integer          default("claim")
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  banner_id    :bigint           not null
#  user_id      :bigint
#
# Indexes
#
#  index_banner_requests_on_banner_id  (banner_id)
#  index_banner_requests_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (banner_id => banners.id)
#  fk_rails_...  (user_id => users.id)
#
class Banner::Request < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :banner

  enum status: { claim: 0, sent: 1 }

  ransacker :address1_or_address2 do
    Arel.sql "CONCAT(address1,'　',address2)"
  end
end
