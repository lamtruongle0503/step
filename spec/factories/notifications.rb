# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id             :bigint           not null, primary key
#  deleted_at     :datetime
#  description    :text
#  gender         :integer
#  is_gender      :boolean          default(FALSE)
#  is_prefecture  :boolean          default(FALSE)
#  is_resend      :boolean          default(FALSE)
#  module_type    :string
#  month_birthday :text             default([]), is an Array
#  send_all       :boolean
#  title          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  module_id      :bigint
#
# Indexes
#
#  index_notifications_on_module  (module_type,module_id)
#
FactoryBot.define do
  factory :notification do
    title { Faker::Lorem.sentence(word_count: 4) }
    description { Faker::Lorem.sentence(word_count: 10) }
    send_all { [true, false].sample }
  end
end
