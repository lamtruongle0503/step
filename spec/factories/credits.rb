# frozen_string_literal: true

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
FactoryBot.define do
  factory :credit do
    association :user
    customer_id { Faker::Lorem.characters(number: 18) }
  end
end
