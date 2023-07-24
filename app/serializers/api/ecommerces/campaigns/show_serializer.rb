# frozen_string_literal: true

class Api::Ecommerces::Campaigns::ShowSerializer < Api::Ecommerces::Campaigns::AttributesSerializer
  # attributes :products
  has_many :products, serializer: Api::Ecommerces::Campaigns::Products::AttributesSerializer

  def products
    object.products.show
  end
end
