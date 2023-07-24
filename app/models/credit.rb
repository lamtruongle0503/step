# == Schema Information
#
# Table name: credits
#
#  id          :bigint           not null, primary key
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :string
#  user_id     :bigint
#
# Indexes
#
#  index_credits_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Credit < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
end
