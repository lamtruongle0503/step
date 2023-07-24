# frozen_string_literal: true

class Api::Ecommerces::Categories::ShowSerializer < Api::Ecommerces::Categories::AttributesSerializer
  has_many :products, serializer: Api::Ecommerces::Products::AttributesSerializer

  def products
    object.products.show
  end
end
