# frozen_string_literal: true

class Api::Ecommerces::Carts::IndexSerializer < ApplicationSerializer
  attributes :id
  attr_reader :actor

  def initialize(object, options = {})
    super
    @actor = options[:actor]
  end

  has_many :order_products, serializer: Api::Ecommerces::Carts::OrderProducts::MetaSerializer
  belongs_to :agency, serializer: Api::Ecommerces::Agencies::AttributesSerializer
end
