# frozen_string_literal: true

module ProductHelper
  def format_discount(discount)
    if discount.to_i.positive?
      "#{discount.to_i}%"
    else
      '適用しない'
    end
  end

  def accessibility(is_show)
    if is_show
      '公開'
    else
      '非公開'
    end
  end

  def format_sizes(product)
    product.product_sizes.map(&:name).join("\n")
  end

  def format_price_sizes(product)
    product.product_sizes.map { |product_size| product_size.price&.to_i }.join("\n")
  end
end
