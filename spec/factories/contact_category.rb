# frozen_string_literal: true

# == Schema Information
#
# Table name: admins
#
#  id              :bigint           not null, primary key
#  name            :string
#  email           :string
#  password_digest :string
#  phone_number    :string
#  deleted_at      :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
  factory :contact_category do
    name { Faker::Tea.type }
  end
end
