# frozen_string_literal: true

class Admin::Ecommerces::Orders::ShowSerializer < Admin::Ecommerces::Orders::AttributesSerializer
  belongs_to :user, serializer: Admin::Users::AttributesSerializer
  has_one :order_info, serializer: Admin::Ecommerces::OrderInfos::AttributesSerializer
  has_many :order_products, serializer: Admin::Ecommerces::Orders::OrderProducts::MetaSerializer
end
