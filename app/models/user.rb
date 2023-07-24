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
class User < ApplicationRecord
  has_paper_trail
  acts_as_paranoid
  strip_attributes
  has_secure_password

  MALE   = 'male'.freeze
  FEMALE = 'female'.freeze
  OTHER  = 'other'.freeze

  APP          = 'app'.freeze
  FRIEND       = 'friend'.freeze
  EXHIBITION   = 'exhibition'.freeze
  STATUS_OTHER = 'status_other'.freeze

  GENDER = [MALE, FEMALE, OTHER].freeze
  USER_STATUS = [APP, FRIEND, EXHIBITION, STATUS_OTHER].freeze

  enum gender: { male: 0, female: 1, other: 2 }
  enum status: { app: 0, friend: 1, exhibition: 2, status_other: 3 }

  attribute :row_number

  has_one :credit, dependent: :destroy
  has_one :assets_module, as: :module, dependent: :destroy
  has_one :asset, through: :assets_module
  has_many :devices, dependent: :destroy
  has_many :users_notifications, dependent: :destroy
  has_many :notifications, through: :users_notifications
  has_many :orders, dependent: :destroy
  has_many :order_infos, through: :orders
  has_many :point_usages, dependent: :destroy
  has_one :user_prefecture, dependent: :destroy
  has_one :prefecture, through: :user_prefecture
  has_many :addresses, dependent: :destroy
  has_one :default_address, -> { default }, class_name: Address.name
  has_many :coupon_users, dependent: :destroy
  has_many :ecommerce_coupon_users
  has_many :ecommerce_coupons, through: :ecommerce_coupon_users, source: :coupon
  has_many :life_support_requests, dependent: :destroy, class_name: 'LifeSupport::Request'
  has_many :banner_requests, dependent: :destroy, class_name: 'Banner::Request'
  # Diary
  has_many :follows, class_name: Follow.name, foreign_key: :follower_id, dependent: :destroy
  has_many :followings, class_name: Follow.name, foreign_key: :followed_id, dependent: :destroy
  has_many :user_blocks, class_name: UserBlock.name, foreign_key: :blocker_id, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :user_contacts, dependent: :destroy
  has_many :tour_orders, dependent: :destroy, class_name: 'Tour::Order', foreign_key: :user_id
  has_many :hotel_orders, dependent: :destroy, class_name: 'Hotel::Order', foreign_key: :user_id

  scope :search_by, lambda { |params|
    return all if params.nil?

    return none unless params[:age_eq].blank? || params[:age_eq].is_integer?

    ransack(params).result(distinct: true)
  }

  scope :receive_notification, lambda {
    where(is_receive: true)
  }

  def cal_point_bonus
    point_usages.where(
      "point_usages.type_point = #{PointUsage.type_points[PointUsage::BONUS]}
      AND :date BETWEEN point_usages.start_date::DATE
      AND point_usages.end_date::DATE", date: Time.zone.now.to_date
    ).not_pending.sum(:received_point)
  end

  def full_name
    "#{first_name}　#{last_name}"
  end

  def furigana
    "#{first_name_kana}　#{last_name_kana}"
  end

  def age
    return nil unless birth_day

    today = Time.zone.now.to_date
    age = today.year - birth_day.year
    age - (today < (birth_day + age.year) ? 1 : 0)
  end

  def csv_infos
    [id, name, furigana, telephone, created_at, gender, birth_day, post_code, address1,
     address2, email, is_dm, note]
  end

  ransacker :full_name do
    Arel.sql "CONCAT(first_name,'　',last_name)"
  end

  ransacker :furigana do
    Arel.sql "CONCAT(first_name_kana,'　',last_name_kana)"
  end

  ransacker :age, type: :integer do
    Arel.sql "date_part('year', age(birth_day))"
  end

  ransacker :created_at, type: :date do
    Arel.sql "DATE(users.created_at + interval '9 hour')"
  end

  ransacker :birth_day, type: :date do
    Arel.sql 'DATE(users.birth_day)'
  end
end
