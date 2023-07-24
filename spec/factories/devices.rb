# frozen_string_literal: true

# == Schema Information
#
# Table name: devices
#
#  id           :bigint           not null, primary key
#  deleted_at   :datetime
#  device_token :string
#  os           :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint
#
# Indexes
#
#  index_devices_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :device do
    association :user
    os { Faker::Lorem.sentence(word_count: 3) }
    device_token { Faker::Lorem.characters(number: 20) }
    is_receive { [true, false].sample }
  end
end
