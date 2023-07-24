# == Schema Information
#
# Table name: user_contacts
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
#  full_name       :string
#  furigana        :string
#  gender          :integer          default("male")
#  is_dm           :boolean          default(TRUE)
#  is_receive      :boolean          default(TRUE)
#  last_name       :string
#  last_name_kana  :string
#  name            :string
#  nick_name       :string
#  note            :text
#  password_digest :string
#  phone_number    :string
#  point           :float            default(0.0)
#  post_code       :string
#  status          :integer          default(0)
#  telephone       :string
#  verify_code     :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_user_contacts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class UserContact < ApplicationRecord
  belongs_to :user, foreign_key: :user_id

  MALE   = 'male'.freeze
  FEMALE = 'female'.freeze
  OTHER  = 'other'.freeze
  enum gender: { male: 0, female: 1, other: 2 }

  ransacker :furigana do
    Arel.sql "CONCAT(first_name_kana,'　',last_name_kana)"
  end

  ransacker :full_name do
    Arel.sql "CONCAT(first_name,'　',last_name)"
  end
end
