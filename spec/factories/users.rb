# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  address1        :string
#  address2        :string
#  birth_day       :date
#  code            :string
#  deleted_at      :datetime
#  diary_flg       :boolean          default(FALSE)
#  email           :string
#  expired_at      :datetime
#  first_name      :string
#  first_name_kana :string
#  gender          :integer
#  is_dm           :boolean          default(TRUE)
#  is_receive      :boolean          default(TRUE)
#  is_verify       :boolean          default(FALSE)
#  last_name       :string
#  last_name_kana  :string
#  name            :string
#  nick_name       :string
#  note            :text
#  password_digest :string
#  phone_number    :string
#  point           :bigint           default(0)
#  point_bonus     :integer          default(0)
#  post_code       :string
#  status          :integer          default("app")
#  telephone       :string
#  verify_code     :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
  factory :user do
    # Define later
    phone_number { 0.to_s << rand(100_000_000..999_999_999).to_s }
    password { Faker::Internet.password }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    first_name_kana { Faker::Name.first_name }
    last_name_kana { Faker::Name.last_name }
    birth_day { DateTime.current - rand(10..30).year }
    address1 { Faker::Address.full_address }
    telephone { Faker::PhoneNumber.cell_phone_in_e164 }
    is_dm { [true, false].sample }
    name { Faker::Name.name }
  end
end
