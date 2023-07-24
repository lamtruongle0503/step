# frozen_string_literal: true

class Admin::Ecommerces::Campaigns::Products::AttributesSerializer <
  Admin::Ecommerces::Campaigns::AttributesSerializer
  has_many :products, serializer: Admin::Ecommerces::Products::AttributesSerializer
end
