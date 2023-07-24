# frozen_string_literal: true

module PdfHelper
  def tour_discount(fee, discount)
    fee * discount / 100 if discount && fee
  end

  def price_special_food_b(bus)
    bus.tour_orders&.first&.tour_order_log&.price_special_food&.dig('price_special_food_b')
  end

  def price_special_food_c(bus)
    bus.tour_orders&.first&.tour_order_log&.price_special_food&.dig('price_special_food_c')
  end

  def format_name(accompany)
    "<span style='font-size: 9px'>#{accompany.full_name}</span><br />#{accompany.furigana}".html_safe
  end

  def format_gender(gender)
    case gender
    when Tour::OrderAccompany::FEMALE
      '女'
    when Tour::OrderAccompany::MALE
      '男'
    else
      'その他'
    end
  end

  def format_owner(is_owner)
    "<div class='full-circle'></div>".html_safe if is_owner
  end

  def format_accompany(is_accompany)
    "<div class='hollow-circle'></div>".html_safe if is_accompany
  end

  def payment_note(accompany)
    accompany.tour_order.payment_note if accompany.is_owner
  end

  def purchased_amount(accompany)
    accompany.tour_order.total if accompany.is_owner
  end

  def option1_price(bus)
    tour_options = bus.tour_orders&.first&.tour_order_log&.tour_options
    tour_options[0]&.dig('option_price') if tour_options
  end

  def option2_price(bus)
    tour_options = bus.tour_orders&.first&.tour_order_log&.tour_options
    tour_options[1]&.dig('option_price') if tour_options
  end

  def option3_price(bus)
    tour_options = bus.tour_orders&.first&.tour_order_log&.tour_options
    tour_options[2]&.dig('option_price') if tour_options
  end

  def option4_price(bus)
    tour_options = bus.tour_orders&.first&.tour_order_log&.tour_options
    tour_options[3]&.dig('option_price') if tour_options
  end

  def option5_price(bus)
    tour_options = bus.tour_orders&.first&.tour_order_log&.tour_options
    tour_options[4]&.dig('option_price') if tour_options
  end

  def accompany_selected(accompany)
    if accompany.tour_order.tour.inday?
      accompany.tour_special_food&.name
    elsif accompany.tour_option
      '&#9733;'.html_safe
    end
  end

  def format_rate(rate)
    "#{rate}%".html_safe if rate
  end

  def total_deposit(data)
    total = 0.0
    data.each_value do |value|
      next unless value[:deposit]

      total += value[:deposit]
    end

    total
  end

  def total_billing(data)
    total = 0.0
    data.each_value do |value|
      next unless value[:billing]

      total += value[:billing]
    end

    total
  end
end
