# == Schema Information
#
# Table name: products
#
#  id                    :bigint           not null, primary key
#  brand                 :string
#  code                  :string
#  colors                :string
#  deleted_at            :datetime
#  delivery_charges_fee  :float
#  description           :text
#  description_info      :text
#  desired_delivery_date :bigint
#  discount              :float
#  distributor           :string
#  exp_date              :string
#  hash_tag              :string
#  is_color              :boolean          default(FALSE)
#  is_delivery_charges   :boolean          default(FALSE)
#  is_delivery_free      :boolean          default(FALSE)
#  is_desired_date_free  :boolean          default(FALSE)
#  is_desired_time_free  :boolean          default(FALSE)
#  is_discount           :boolean          default(FALSE)
#  is_limit              :boolean          default(FALSE)
#  is_product_size       :boolean          default(TRUE)
#  is_show               :boolean          default(TRUE)
#  name                  :string
#  option_color_name     :string
#  option_name           :string
#  original_country      :string
#  point_bonus           :integer
#  point_end_date        :date
#  point_start_date      :date
#  precaution            :string
#  remaining_count       :integer          default(0)
#  shipping_memo         :text
#  shipping_others       :text
#  tax                   :integer          default(10)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  agency_id             :bigint
#  category_id           :bigint
#
# Indexes
#
#  index_products_on_agency_id    (agency_id)
#  index_products_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#
class Product < ApplicationRecord
  attr_accessor :delivery_amount

  acts_as_paranoid

  belongs_to :category
  belongs_to :agency, optional: true

  has_many :campaign_products, dependent: :destroy
  has_many :campaigns, through: :campaign_products
  has_many :delivery_time_settings, dependent: :destroy
  has_many :product_sizes, dependent: :destroy, inverse_of: :product
  has_many :assets_modules, as: :module, dependent: :destroy
  has_many :assets, through: :assets_modules
  has_many :product_area_settings
  has_many :area_settings, through: :product_area_settings
  has_many :payments, through: :agency
  has_many :deliveries, through: :agency
  has_one :coupons_module, as: :module, dependent: :destroy
  has_one :coupon, through: :coupons_module

  accepts_nested_attributes_for :product_sizes, :delivery_time_settings,
                                :product_area_settings, allow_destroy: true

  scope :by_category, lambda { |category_id|
    return unless category_id

    where(category_id: category_id)
  }

  scope :order_price_desc, lambda { |price_desc|
    return unless price_desc

    joins(:product_sizes).group('products.id').order(
      Arel.sql(
        'CASE WHEN is_discount = TRUE THEN
          MIN(product_sizes.price - ((products.discount * product_sizes.price) / 100))
        ELSE
          MIN(product_sizes.price)
        END DESC',
      ),
    )
  }

  scope :order_price_asc, lambda { |price_asc|
    return unless price_asc

    joins(:product_sizes).group('products.id').order(
      Arel.sql(
        'CASE WHEN is_discount = TRUE THEN
          MIN(product_sizes.price - ((products.discount * product_sizes.price) / 100))
        ELSE
          MIN(product_sizes.price)
        END ASC',
      ),
    )
  }

  scope :order_newest, lambda { |newest|
    return unless newest

    order(created_at: :desc)
  }

  scope :show, -> { where(is_show: true) }
end
