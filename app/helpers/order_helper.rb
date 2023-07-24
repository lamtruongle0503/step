# frozen_string_literal: true

module OrderHelper # rubocop:disable Metrics/ModuleLength
  def create_order_info!(user, order, params)
    EcommerceContracts::OrderInfoContracts::Create.new(params.merge(user: user)).valid!
    order.create_order_info!(params)
  end

  def update_remaining_product!(order)
    order.product_sizes.each do |product_size|
      product_size.with_lock do
        order.order_products.each do |order_product|
          next unless product_size.id == order_product.product_size.id && product_size.is_limit

          remaining_count = product_size.remaining_count - order_product.number
          if remaining_count.negative?
            return raise BadRequestError,
                         remaining_count: I18n.t('order_products.remain_product_must_greater_than_zero')
          end
          product_size.update(remaining_count: remaining_count)
        end
      end
    end
  end

  def update_coupon_user!(user, params)
    return unless params[:coupon_id]

    ec_coupon = user.ecommerce_coupon_users.find_by(coupon_id: params[:coupon_id])
    ec_coupon&.update(is_used: true)
  end

  def create_point_usages(user, order, used_point)
    user.point_usages.create!(module: order, used_point: used_point)
  end

  def update_user_point(user, used_point)
    user.decrement!(:point, used_point)
  end

  def create_coupon_order!(order, coupon)
    return unless coupon

    order.create_coupon_order!(coupon: coupon)
  end

  def product_point_bonus_available?(product)
    start_date = product.point_start_date
    end_date = product.point_end_date

    return false if start_date.blank? || end_date.blank?

    Time.current.to_date.between?(start_date, end_date)
  end

  def create_order_log!(order)
    order.order_products.each do |order_product|
      order_product.create_order_log!(
        product:      order_product.product.to_json,
        product_size: order_product.product_size.to_json,
      )
    end
  end

  def product_name(order)
    order.order_products.map do |order_product|
      order_product.product_size.product.name
    end.uniq.join("\n")
  end

  def format_buyer(user)
    "#{user.code}\n#{user.full_name}"
  end

  def format_payment_method(payment_method)
    case payment_method
    when Order::CREDIT_CARD
      'クレジットカード'
    when Order::CONVENIENCE_STORE
      'コンビニ'
    when Order::ON_DELIVERY
      '代引'
    when Order::BANK_TRANSFER
      '銀行振込'
    end
  end

  def format_payment_status(status)
    case status
    when Order::PENDING
      '未入金'
    when Order::SUCCEEDED
      '入金済み'
    when Order::FAILED
      '未出荷'
    when Order::REFUNED
      '返金した'
    end
  end

  def format_delivery_status(order)
    case order.delivery_status
    when Order::DELIVERIED
      I18n.l(order.delivered_date, format: :common) if order.delivered_date
    when Order::NOT_DELIVERY
      '未出荷'
    end
  end

  def format_checkout_date(date)
    I18n.l(date, format: :common) if date
  end

  def format_order_status(status)
    case status
    when Order::INPROGRESS
      '注文中'
    when Order::CONFIRM
      '確認済み'
    when Order::DONE
      '注文済み'
    when Order::DELIVERY
      '出荷中'
    when Order::CANCEL
      'キャンセル'
    end
  end

  #### Improve Logic
  def calc_product_amount(order)
    total_payment_amount = 0
    order.order_products.each do |order_product|
      product      = order_product.product
      product_size = order_product.product_size
      discount     = product.discount
      price        = if product.is_discount
                       product_size.price.discount_of(discount)
                     else
                       product_size.price
                     end
      total_payment_amount += price * order_product.number
    end
    total_payment_amount
  end

  def find_shipping_fee(product, postcode)
    addresses       = ZipCodeJp.find(postcode) if ZipCodeJp.find(postcode)
    prefecture_name = addresses.is_a?(Array) ? addresses.first.prefecture : addresses.prefecture
    area_setting_id = Prefecture.where(name: prefecture_name).first&.area_setting&.id
    shipping_fee    = product.product_area_settings.where(area_setting_id: area_setting_id).first&.price
    shipping_fee&.to_i
  end

  def calc_product_shipping_fee(order, user_address_id)
    arr_fee_ship = []
    user         = order.user
    user_address = Address.find_by(id: user_address_id)
    postcode     = if user_address.present?
                     user_address.postcode
                   else
                     user.default_address&.postcode
                   end
    order.order_products.each do |order_product|
      product = order_product.product
      next if product.is_delivery_free

      arr_fee_ship << find_shipping_fee(product, postcode) if postcode && ZipCodeJp.find(postcode)
    end
    arr_fee_ship.compact.max
  end

  def calc_order_shipping_free_fee(order, user_address_id)
    shipping_free_fee      = 0
    product_payment_amount = calc_product_amount(order)
    product_shipping_fee   = calc_product_shipping_fee(order, user_address_id)
    if order.agency.is_free && (product_payment_amount.to_i >= order.agency.fee_shipping.to_i)
      shipping_free_fee = if order.agency.fee_shipping.to_i >= product_shipping_fee.to_i
                            product_shipping_fee
                          else
                            order.agency.fee_shipping.to_i
                          end
    end
    shipping_free_fee
  end

  def calc_total_shipping_fee(order, user_address_id)
    product_payment_amount = calc_product_amount(order)
    product_shipping_fee   = calc_product_shipping_fee(order, user_address_id)
    if order.agency.is_free && (product_payment_amount.to_i >= order.agency.fee_shipping.to_i)
      product_shipping_fee = 0
    end
    product_shipping_fee
  end

  def calc_product_payment_amount(order, coupon, user_address_id)
    product_amount  = calc_product_amount(order)
    shipping_fee    = calc_total_shipping_fee(order, user_address_id)
    product_amount -= coupon.price if coupon
    product_amount.to_i + shipping_fee.to_i
  end

  def calc_total_payment_amount(order, coupon, user_address_id)
    product_payment_amount = calc_product_payment_amount(order, coupon, user_address_id)
    delivery_charge_fee    = order.payment.code == Order::ON_DELIVERY ? calc_delivery_charge_fee(order) : 0
    product_payment_amount + delivery_charge_fee.to_i
  end

  def calc_bonus_point_used(order, use_point, product_payment_amount, is_apply_point) # rubocop:disable Metrics/PerceivedComplexity
    return 0 unless is_apply_point

    user        = order.user
    bonus_point = user.point_bonus
    return 0 unless bonus_point.positive?

    if use_point.positive?
      use_point = product_payment_amount if use_point >= product_payment_amount
      if bonus_point >= use_point
        use_point
      else
        bonus_point
      end
    elsif bonus_point >= product_payment_amount
      product_payment_amount
    else
      bonus_point
    end
  end

  def calc_normal_point_used(order, use_point, bonus_point_use, product_payment_amount, is_apply_point) # rubocop:disable Metrics/PerceivedComplexity
    return 0 unless is_apply_point

    user         = order.user
    normal_point = user.point
    return 0 unless normal_point.positive?

    product_payment_amount -= bonus_point_use
    return 0 if (use_point - bonus_point_use).zero?

    if use_point.positive?
      use_point = product_payment_amount if use_point >= product_payment_amount
      if normal_point >= use_point
        use_point
      else
        normal_point
      end
    elsif normal_point >= product_payment_amount
      product_payment_amount
    else
      normal_point
    end
  end

  def calc_point_used(order, use_point, coupon, user_address_id, is_apply_point)
    return 0 unless is_apply_point

    product_payment_amount = calc_total_payment_amount(order, coupon, user_address_id)
    bonus_point_use        = calc_bonus_point_used(order, use_point, product_payment_amount, is_apply_point)
    normal_point_use       = calc_normal_point_used(order, use_point, bonus_point_use, product_payment_amount,
                                                    is_apply_point)
    bonus_point_use + normal_point_use
  end

  def decrement_point_used!(order, use_point, coupon, is_apply_point, user_address_id)
    user_point_normal = user.point
    user_point_bonus  = user.point_bonus
    product_payment_amount = calc_total_payment_amount(order, coupon, user_address_id)
    bonus_point_use   = calc_bonus_point_used(order, use_point, product_payment_amount, is_apply_point)
    normal_point_use  = calc_normal_point_used(order, use_point, bonus_point_use, product_payment_amount,
                                               is_apply_point)
    user.point        = user_point_normal - normal_point_use
    user.point_bonus  = user_point_bonus - bonus_point_use
    user.save!
  end

  def calc_payment_amount(order, use_point, coupon, user_address_id, is_apply_point)
    product_payment     = calc_product_payment_amount(order, coupon, user_address_id)
    point_use           = calc_point_used(order, use_point, coupon, user_address_id, is_apply_point)
    delivery_charge_fee = order.payment.code == Order::ON_DELIVERY ? calc_delivery_charge_fee(order) : 0
    product_payment + delivery_charge_fee - point_use
  end

  def payment_order(order, use_point, coupon, user_address_id, is_apply_point)
    purchased_amount = calc_payment_amount(order, use_point, coupon, user_address_id, is_apply_point)
    used_point = calc_point_used(order, use_point, coupon, user_address_id, is_apply_point)

    case order.payment.code
    when Order::CREDIT_CARD
      customer_id = user.credit.customer_id
      description = "user: #{user.phone_number} purchased order_code: #{order.code}"
      unless purchased_amount.zero?
        payment = StripeService.payment(customer_id, purchased_amount.to_i, description)
        order.payment_status = payment.status
        order.purchased_id = payment.id
      end
      order.payment_status = Order::SUCCEEDED
      order.coupon_amount = coupon&.price.to_f
    when Order::ON_DELIVERY
      order.payment_status = Order::CASH_ON_DELIVERY
      order.delivery_charges_fee = calc_delivery_charge_fee(order)
    else
      order.payment_status = Order::PENDING
    end
    order.purchased_amount     = purchased_amount
    order.delivery_amount      = calc_product_shipping_fee(order, user_address_id)
    order.delivery_free_amount = calc_order_shipping_free_fee(order, user_address_id)
    order.used_point           = used_point
    order.coupon_amount        = coupon&.price.to_i
    order.save!
  end

  def calc_delivery_charge_fee(order)
    order.products
         .where(is_delivery_charges: true)
         .map(&:delivery_charges_fee)
         .max
         .to_i
  end

  def cal_product_amount_no_tax(order, coupon)
    total_payment_amount = 0
    order.order_products.each do |order_product|
      product = order_product.product
      product_size = order_product.product_size
      discount     = product.discount
      tax          = product.tax
      unit_price   = order_product.number * if product.is_discount
                                              product_size.price.discount_of(discount)
                                            else
                                              product_size.price
                                            end
      price        = coupon && coupon.products[0].id == product.id ? unit_price - coupon.price : unit_price
      total_payment_amount +=
        BigDecimal(price.to_s) / BigDecimal((1 + (tax.to_f / 100)).to_s)
    end
    total_payment_amount
  end

  def earn_normal_point(order, coupon, _is_apply_point)
    user           = order.user
    payment_no_tax = cal_product_amount_no_tax(order, coupon)
    point_received = payment_no_tax / (1 * 100)
    order.received_point = point_received.to_i

    user.point_usages.create!(
      module:         order,
      received_point: point_received,
      type_point:     PointUsage::NORMAL,
      status:         PointUsage::PENDING,
    )
  end

  def earn_bonus_point(order, coupon, use_point, is_apply_point, user_address_id) # rubocop:disable Metrics/PerceivedComplexity
    user = order.user
    total_point_use = calc_point_used(order, use_point, coupon, user_address_id, is_apply_point)
    payment_no_tax = cal_product_amount_no_tax(order, coupon)
    bonus_rate = order.order_products.map(&:product).sum do |p|
      if p.point_bonus.present? && Date.current.between?(p.point_start_date, p.point_end_date)
        p.point_bonus
      else
        0
      end
    end.to_i
    return if bonus_rate.zero?

    point_received = if total_point_use >= payment_no_tax
                       0
                     else
                       (payment_no_tax - total_point_use).to_i * (bonus_rate.to_f / 100)
                     end
    order.received_bonus_point = point_received.to_i
    return if point_received.to_i.zero?

    user.point_usages.create!(
      module:         order,
      received_point: point_received,
      type_point:     PointUsage::BONUS,
      status:         PointUsage::PENDING,
    )
  end
end
