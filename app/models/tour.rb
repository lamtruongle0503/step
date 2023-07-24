# == Schema Information
#
# Table name: tours
#
#  id                          :bigint           not null, primary key
#  code                        :string
#  deleted_at                  :datetime
#  destination                 :string
#  discount                    :integer
#  end_date                    :date
#  end_time                    :date
#  exp_point_bonus             :bigint
#  exp_point_receive           :bigint
#  first_row_seat_price        :bigint
#  hostel_list                 :integer
#  hotel_description           :string
#  info_travel_fee             :string
#  is_show_guide               :boolean          default(FALSE)
#  meal_description            :string
#  min_number_participant      :bigint
#  name                        :string
#  note                        :string
#  options                     :string
#  other_fee                   :string
#  plan_implement              :string
#  point_bonus_rate            :integer
#  point_receive_rate          :integer
#  regular_seat_price          :bigint
#  scheduler                   :string
#  sight_seeing                :string
#  start_date                  :date
#  start_time                  :date
#  status                      :integer          default("posted")
#  stayed_nights               :integer
#  stop_locations              :string
#  stopover                    :string
#  tax                         :integer
#  title                       :string
#  tour_guide                  :string
#  transport_used              :string
#  two_rows_seat_price         :float
#  type_locate                 :integer          default("inday")
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  company_staff_id            :bigint
#  tour_cancellation_policy_id :integer
#  tour_category_id            :bigint
#  tour_company_id             :bigint
#
# Indexes
#
#  index_tours_on_company_staff_id  (company_staff_id)
#  index_tours_on_tour_category_id  (tour_category_id)
#  index_tours_on_tour_company_id   (tour_company_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_staff_id => company_staffs.id)
#  fk_rails_...  (tour_category_id => tour_categories.id)
#
class Tour < ApplicationRecord
  acts_as_paranoid

  belongs_to :tour_category, class_name: 'Tour::Category', foreign_key: 'tour_category_id', optional: true
  belongs_to :company_staff, optional: true
  belongs_to :tour_company, class_name: 'Tour::Company', foreign_key: 'tour_company_id', optional: true
  belongs_to :tour_cancellation_policy, class_name: 'Tour::CancellationPolicy',
                                        foreign_key: 'tour_cancellation_policy_id', optional: true

  has_many :tour_special_foods, class_name: 'Tour::SpecialFood', foreign_key: 'tour_id', dependent: :destroy
  has_many :hostels_tours, class_name: 'Tour::HostelsTour', foreign_key: 'tour_id', dependent: :destroy
  has_many :hostels, through: :hostels_tours, dependent: :destroy, source: :tour_hostel
  has_many :tour_place_starts, dependent: :destroy, class_name: 'Tour::PlaceStart', foreign_key: :tour_id
  has_many :tour_stay_departures, class_name: 'Tour::StayDeparture', foreign_key: 'tour_id',
                                  dependent: :destroy
  has_many :tour_options, class_name: 'Tour::Option', foreign_key: 'tour_id', dependent: :destroy

  has_many :coupons_modules, as: :module, dependent: :destroy
  has_many :coupons, through: :coupons_modules, dependent: :destroy
  has_many :tours_prefectures, dependent: :destroy
  has_many :assets_modules, as: :module, dependent: :destroy
  has_many :assets, through: :assets_modules, dependent: :destroy
  has_one :notification, as: :module, dependent: :destroy
  has_one :tour_information, class_name: 'Tour::Information', dependent: :destroy
  has_many :tour_start_locations, dependent: :destroy, class_name: 'Tour::StartLocation',
                                  foreign_key: 'tour_id'
  has_many :prefectures, through: :tour_start_locations, dependent: :destroy
  has_many :hostel_departures, dependent: :destroy, class_name: 'Tour::HostelDeparture'
  has_many :tour_bus_infos, dependent: :destroy, class_name: 'Tour::BusInfo'
  has_many :tour_orders, dependent: :destroy, class_name: 'Tour::Order'
  has_many :coupon_tours, dependent: :destroy, class_name: 'CouponTour'
  has_many :tour_management_files, dependent: :destroy, class_name: 'Tour::ManagementFile'
  has_many :tour_temporaries, dependent: :destroy, class_name: 'Tour::Temporary'

  has_many :coupons_available, -> { available }, source: :coupon, through: :coupons_modules
  has_many :tour_order_specials, dependent: :destroy, class_name: 'Tour::OrderSpecial'
  has_many :tour_payments, dependent: :destroy, class_name: 'TourPayment', foreign_key: 'tour_id'
  has_many :payments, through: :tour_payments

  INDAY     = 'inday'.freeze
  STAY      = 'stay'.freeze
  POSTED    = 'posted'.freeze
  NO_POSTED = 'no_posted'.freeze
  ENDED     = 'ended'.freeze

  enum status: { posted: 0, no_posted: 1, ended: 2 }
  enum type_locate: { inday: 0, stay: 1 }

  scope :available, lambda {
    where(':date BETWEEN start_date AND end_date', date: Date.current)
  }

  scope :available_by_end_date, lambda {
    where('end_date >= ?', Date.current)
  }

  ransacker :status, formatter: proc { |v| statuses[v] }

  scope :by_end_date_and_status_posted, lambda {
    where('end_date >= ? AND status = ?', Date.current, Tour.statuses[Tour::POSTED])
  }

  scope :by_status_posted, lambda {
    where(status: Tour.statuses[Tour::POSTED])
  }

  scope :by_end_date, lambda { |end_date, type_locate|
    where('tours.end_date >= ? AND tours.type_locate = ?', end_date, type_locate)
  }

  scope :by_type_locate_and_address, lambda { |type_locate, name, address|
    if type_locate == Tour::STAY
      joins(:tour_stay_departures).where(
        type_locate: Tour.type_locates[type_locate], tour_stay_departures: { name: name, address: address },
      )
    else
      joins(:tour_start_locations).where(
        type_locate: Tour.type_locates[type_locate], tour_start_locations: { name: name, address: address },
      )
    end
  }

  scope :by_prefecture_name, lambda { |type_locate, name|
    if type_locate == Tour::STAY
      joins(:tour_stay_departures).where(
        type_locate: Tour.type_locates[type_locate], tour_stay_departures: { name: name },
      )
    else
      joins(:tour_start_locations).where(
        type_locate: Tour.type_locates[type_locate], tour_start_locations: { name: name },
      )
    end
  }
end
