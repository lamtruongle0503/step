# frozen_string_literal: true

class Api::Ecommerces::Products::Coupons::AttributesSerializer < Api::Coupons::AttributeSerializer
  attributes :is_received

  attr_reader :actor

  def initialize(object, options = {})
    super
    @actor = options[:actor]
  end

  def is_received # rubocop:disable Naming/PredicateName
    return false if actor.blank?

    actor.ecommerce_coupons.pluck(:id).include?(object.id)
  end
end
