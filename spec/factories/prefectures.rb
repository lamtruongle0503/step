# frozen_string_literal: true

# == Schema Information
#
# Table name: prefectures
#
#  id                  :bigint           not null, primary key
#  deleted_at          :datetime
#  name                :string
#  prefecture_jis_code :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  area_setting_id     :bigint
#  location_area_id    :integer
#
# Indexes
#
#  index_prefectures_on_area_setting_id  (area_setting_id)
#
# Foreign Keys
#
#  fk_rails_...  (area_setting_id => area_settings.id)
#
FactoryBot.define do
  factory :prefecture do
    name { Faker::Lorem.sentence(word_count: 3) }
    prefecture_jis_code { Faker::Address.zip_code }
    location_area_id { rand(1..10) }
  end
end
