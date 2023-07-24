# frozen_string_literal: true

# == Schema Information
#
# Table name: contacts
#
#  id                  :bigint           not null, primary key
#  code                :string
#  contents            :text
#  deleted_at          :datetime
#  email               :string
#  furigana            :string
#  phone_number        :string
#  status              :integer          default("open")
#  todo                :string
#  user                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  contact_category_id :integer
#
FactoryBot.define do
  factory :contact do
    contents { Faker::Lorem.sentence(word_count: 3) }
    phone_number { 0.to_s << rand(100_000_000..999_999_999).to_s }
    email { Faker::Internet.email }
    user { Faker::Name.name }
    association :contact_category
  end
end
