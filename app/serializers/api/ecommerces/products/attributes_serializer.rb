# frozen_string_literal: true

class Api::Ecommerces::Products::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :code, :description, :discount, :colors, :description_info, :brand,
             :original_country, :distributor, :precaution, :desired_delivery_date, :hash_tag,
             :deleted_at, :remaining_count, :is_limit, :exp_date, :is_delivery_free,
             :agency_id, :tax, :is_product_size, :shipping_memo,
             :shipping_others, :is_show,
             :point_bonus,
             :point_start_date,
             :point_end_date,
             :is_color,
             :is_discount,
             :is_delivery_charges, :delivery_charges_fee

  def colors
    object.colors&.split(/、|, |,|,、/)&.compact_blank
  end

  def remaining_count
    return 10 if object.product_sizes.pluck(:is_limit).include?(false)

    object.product_sizes.pluck(:remaining_count).compact.max
  end
end
