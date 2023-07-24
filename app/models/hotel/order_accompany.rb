# == Schema Information
#
# Table name: hotel_order_accompanies
#
#  id              :bigint           not null, primary key
#  address1        :string
#  address2        :string
#  birth_day       :date
#  deleted_at      :datetime
#  email           :string
#  first_name      :string
#  first_name_kana :string
#  gender          :integer          default("male")
#  is_owner        :boolean          default(FALSE)
#  last_name       :string
#  last_name_kana  :string
#  phone_number    :string
#  postal_code     :string
#  telephone       :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Hotel::OrderAccompany < ApplicationRecord
  acts_as_paranoid

  has_many :hotel_order, foreign_key: :hotel_order_accompany_id, dependent: :destroy,
           class_name: 'Hotel::Order'

  MALE   = 'male'.freeze
  FEMALE = 'female'.freeze
  OTHER  = 'other'.freeze

  enum gender: { male: 0, female: 1, other: 2 }
end
