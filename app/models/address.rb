# == Schema Information
#
# Table name: addresses
#
#  id         :bigint           not null, primary key
#  address1   :string
#  address2   :string
#  deleted_at :datetime
#  full_name  :string
#  is_default :boolean          default(FALSE)
#  postcode   :string
#  telephone  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_addresses_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Address < ApplicationRecord
  acts_as_paranoid

  belongs_to :user

  scope :default, -> { where is_default: true }
end
