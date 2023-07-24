# frozen_string_literal: true

module TourOrderHelper # rubocop:disable Metrics/ModuleLength
  def total_tour_information(tour_order, params)
    count_amount = count_amount_tour_order(tour_order.tour_order_accompanies, params)
    if tour_order.tour_bus_info.is_weekend == Tour::BusInfo::WEEKDAY
      total_money_dayoff(count_amount)
    else
      total_money_weekday(count_amount)
    end
  end

  def count_amount_tour_order(tour_order_accompanies, params)
    # adult_amount = 0
    # child_amount = 0
    # baby_amount = 0
    # tour_order_accompanies.each do |tour_order_accompany|
    #   age = cal_age(tour_order_accompany[:birth_day])
    #   if age < 7
    #     baby_amount += 1
    #   elsif age > 12
    #     adult_amount += 1
    #   else
    #     child_amount += 1
    #   end
    # end
    adult_amount = params[:adult_number].to_i
    child_amount = params[:child_number].to_i
    baby_amount = params[:baby_number].to_i
    if tour_order_accompanies.length == (adult_amount + child_amount + baby_amount)
      { adult_amount: adult_amount, child_amount: child_amount, baby_amount: baby_amount }
    else
      raise BadRequestError,
            tour_order: I18n.t('order_tours.tour_informations.info')
    end
  end

  def cal_age(birthday)
    now = Time.now.utc.to_date
    now.year - birthday.year - (if now.month > birthday.month ||
                               (now.month == birthday.month && now.day >= birthday.day)
                                  0
                                else
                                  1
                                end)
  end

  def total_tour_bus_seat_map(tour_order, tour_bus_info)
    return 0 if tour_order.is_seats_bus_free == Tour::Order::FREE

    amount_seat_selected = amount_tour_bus_seat_map(tour_order, tour_bus_info)
    (amount_seat_selected[:row1] * tour.first_row_seat_price) +
      (amount_seat_selected[:row2] * tour.two_rows_seat_price) +
      (amount_seat_selected[:row3] * tour.two_rows_seat_price) +
      (amount_seat_selected[:special_row] * tour.regular_seat_price)
  end

  def total_tour_bus_seat_map_admin(tour_order, tour_bus_info)
    return 0 if tour_order.is_seats_bus_free == Tour::Order::FREE

    amount_seat_selected = amount_tour_bus_seat_map(tour_order, tour_bus_info)
    (amount_seat_selected[:row1] * tour_order.price_seat['first_row_seat_price'].to_i) +
      (amount_seat_selected[:row2] * tour_order.price_seat['two_rows_seat_price'].to_i) +
      (amount_seat_selected[:row3] * tour_order.price_seat['two_rows_seat_price'].to_i) +
      (amount_seat_selected[:special_row] * tour_order.price_seat['regular_seat_price'].to_i)
  end

  def total_price_special_food(tour_order)
    price_special_food = price_special_food(tour)
    count_amount_special_food = count_amount_special_food(tour_order.tour_order_accompanies)
    (count_amount_special_food[:c] * price_special_food[:price_special_food_c].to_i) +
      (count_amount_special_food[:b] * price_special_food[:price_special_food_b].to_i) +
      (count_amount_special_food[:a] * price_special_food[:price_special_food_a].to_i)
  end

  def total_price_food_admin(tour_order)
    tour_order.tour_order_accompanies.inject(0) do |sum, tour_order_accompany|
      sum + tour_order_accompany.price_food['price'].to_i
    end
  end

  def price_special_food_admin(tour_order)
    price_special_food = {}
    tour_order.tour_order_accompanies.each do |tour_order_accompany|
      price_special_food["price_special_food_#{tour_order_accompany.price_food['code']}"] =
        tour_order_accompany.price_food['price']
    end
    price_special_food
  end

  def price_special_food(tour)
    price_special_food_c = check_price(tour.tour_special_foods.find_by(code: 'c'))
    price_special_food_b = check_price(tour.tour_special_foods.find_by(code: 'b'))
    price_special_food_a = check_price(tour.tour_special_foods.find_by(code: 'a'))
    { price_special_food_a: price_special_food_a,
      price_special_food_b: price_special_food_b,
      price_special_food_c: price_special_food_c }
  end

  def total_tour_stay_departure_price(tour_order, tour_order_params)
    tour_stay_departure = tour_order.tour_bus_info.tour_stay_departure
    one_person_fee = tour_stay_departure.one_person_fee - tour.discount
    two_person_fee = tour_stay_departure.two_person_fee - tour.discount
    three_person_fee = tour_stay_departure.three_person_fee - tour.discount
    four_person_fee = tour_stay_departure.four_person_fee - tour.discount
    amount_one_person = tour_order_params[:room][:one_person_fee]
    amount_two_person = tour_order_params[:room][:two_person_fee] * 2
    amount_three_person = tour_order_params[:room][:three_person_fee] * 3
    amount_four_person = tour_order_params[:room][:four_person_fee] * 4
    (amount_one_person * one_person_fee) + (amount_two_person * two_person_fee) +
      (amount_three_person * three_person_fee) + (amount_four_person * four_person_fee)
  end

  def price_option(tour_order)
    options = []
    tour_order.tour_order_accompanies.each do |tour_order_accompany|
      next unless tour_order_accompany.tour_option_id.present?

      price = tour_order_accompany.tour_option.is_free.present? ? 0 : tour_order_accompany.tour_option.price
      options.push(id:    tour_order_accompany.tour_option.id,
                   name:  tour_order_accompany.tour_option.name,
                   price: price,
                   code:  tour_order_accompany.tour_option.code)
    end
    count_amount_option(options)
  end

  def price_option_admin(tour_order)
    options = []
    tour_order.tour_order_accompanies.each do |tour_order_accompany|
      options.push(id:    tour_order_accompany.price_food['id'],
                   name:  tour_order_accompany.price_food['name'],
                   price: tour_order_accompany.price_food['price'],
                   code:  tour_order_accompany.price_food['code'])
    end
    count_amount_option(options)
  end

  def count_amount_option(options)
    amount_options = []
    if options.present?
      options_new = options.group_by(&:itself).transform_values(&:count)
      options_new.each do |option|
        amount_options.push(id: option[0][:id], option_name: option[0][:name],
                            option_price: option[0][:price], amount: option[1])
      end
    end
    amount_options
  end

  def total_price_option(tour_order)
    tour_option_price = 0
    tour_order.tour_order_accompanies.each do |tour_order_accompany|
      next unless tour_order_accompany.tour_option_id.present?

      tour_option_price += check_price(tour_order_accompany.tour_option)
    end
    tour_option_price
  end

  def total_tour_order_inday(tour_order, total_tour_information,
                             total_tour_bus_seat_map, total_price_special_food)
    tour_coupon = tour_order.coupon_id.present? ? tour.coupons.find(tour_order.coupon_id).price : 0
    initial_price = total_tour_information + total_tour_bus_seat_map + total_price_special_food
    total_tour_order_inday = initial_price - tour_coupon - tour_order.used_points

    {
      total_tour_information:   total_tour_information,
      total_tour_bus_seat_map:  total_tour_bus_seat_map,
      total_price_special_food: total_price_special_food,
      initial_price:            initial_price,
      total_tour_order_inday:   total_tour_order_inday,
      tour_coupon:              tour_coupon,
    }
  end

  def total_tour_order_stay(
    tour_order, total_tour_bus_seat_map,
    total_price_option, total_price_stay_departure
  )
    tour_coupon = tour_order.coupon_id.present? ? tour.coupons.find(tour_order.coupon_id).price : 0
    initial_price = total_tour_bus_seat_map + total_price_option + total_price_stay_departure
    total_tour_order_stay = initial_price - tour_coupon - tour_order.used_points

    total_tour_order_stay = 0 if total_tour_order_stay.negative?
    { total_tour_bus_seat_map: total_tour_bus_seat_map, total_price_option: total_price_option,
      total_price_stay_departure: total_price_stay_departure, initial_price: initial_price,
      total_tour_order_stay: total_tour_order_stay, tour_coupon: tour_coupon }
  end

  def count_amount_special_food(tour_order_accompanies)
    amount_special_food_c = 0
    amount_special_food_b = 0
    amount_special_food_a = 0
    tour_order_accompanies.each do |tour_order_accompany|
      if tour_order_accompany[:tour_special_food_id].present?
        code = tour.tour_special_foods.find(tour_order_accompany[:tour_special_food_id]).code
      end
      case code
      when 'c'
        amount_special_food_c += 1
      when 'b'
        amount_special_food_b += 1
      when 'a'
        amount_special_food_a += 1
      end
    end
    { c: amount_special_food_c, b: amount_special_food_b, a: amount_special_food_a }
  end

  def amount_tour_bus_seat_map(tour_order, tour_bus_info)
    row1 = 0
    row2 = 0
    row3 = 0
    special_row = 0
    selected_seat_map = select_seat(tour_order.tour_order_accompanies)
    tour_bus_info.seats_map.each do |seat_map|
      seat_map.each do |seat|
        next unless selected_seat_map.values.include? seat['name']

        full_name = user_name_for_seat(tour_order, selected_seat_map.key(seat['name']).to_s.to_i)
        seat.merge!(full_name: full_name)

        case seat['row']
        when 1
          row1 += 1
        when 2
          row2 += 1
        when 3
          row3 += 1
        else
          special_row += 1
        end
      end
    end
    tour_bus_info.save!
    { row1: row1, row2: row2, row3: row3, special_row: special_row,
      selected_seat_map: selected_seat_map.values }
  end

  def select_seat(tour_order_accompanies)
    selected_seat_map = {}
    tour_order_accompanies.each do |tour_order_accompany|
      selected_seat_map.merge!("#{tour_order_accompany[:id]}": tour_order_accompany[:selected_seat])
    end
    selected_seat_map
  end

  def user_name_for_seat(tour_order, id)
    order_accompany = tour_order.tour_order_accompanies.find(id)
    "#{order_accompany.first_name}　#{order_accompany.last_name}"
  end

  def total_money_dayoff(count_amount)
    total_adult_price = count_amount[:adult_amount] * tour.tour_information.adult_dayoff_amount
    total_child_price = count_amount[:child_amount] * tour.tour_information.children_dayoff_amount
    total_baby_price  = count_amount[:baby_amount] * tour.tour_information.baby_dayoff_amount
    total_adult_price + total_child_price + total_baby_price
  end

  def total_money_weekday(count_amount)
    total_adult_price = count_amount[:adult_amount] * tour.tour_information.adult_weekday_amount
    total_child_price = count_amount[:child_amount] * tour.tour_information.children_weekday_amount
    total_baby_price  = count_amount[:baby_amount] * tour.tour_information.baby_weekday_amount
    total_adult_price + total_child_price + total_baby_price
  end

  def price_tour_information(tour_order)
    if tour_order.tour_bus_info.is_weekend == Tour::BusInfo::WEEKDAY
      adult_price = tour.tour_information.adult_dayoff_amount
      child_price = tour.tour_information.children_dayoff_amount
      baby_price = tour.tour_information.baby_dayoff_amount
    else
      adult_price = tour.tour_information.adult_weekday_amount
      child_price = tour.tour_information.children_weekday_amount
      baby_price = tour.tour_information.baby_weekday_amount
    end
    { adult_price: adult_price, child_price: child_price, baby_price: baby_price }
  end

  def payment_tour(customer_id, total_price, description, card_id)
    StripeService.payment_with_card(
      customer_id, total_price, description, card_id
    )
  end

  def check_price(price_food)
    price_food.is_free.present? ? 0 : price_food.price.to_i
  end

  def update_tour_bus_info(seat_selection, bus_seat_map)
    seat_booked = find_seat_booked(seat_selection, bus_seat_map)
    if seat_booked.present?
      raise BadRequestError,
            tour_bus_info: I18n.t('order_tours.bus_infos.seat_position', seat_booked: seat_booked.join(', ')),
            seat_booked:   seat_booked
    else
      update_seat_booking(seat_selection, bus_seat_map)
    end
    bus_seat_map
  end

  def find_seat_booked(seat_selection, bus_seat_map)
    seat_booked = []
    bus_seat_map.each do |seat_map|
      seat_map.each do |seat|
        if seat_selection.include?(seat['name']) && seat['status'] == Tour::BusInfo::BOOKING
          seat_booked << seat['name']
        end
      end
    end
    seat_booked
  end

  def update_available_seats(tour_order, tour_bus_info)
    tour_bus_info.update!(
      available_seats: tour_bus_info.available_seats - tour_order.tour_order_accompanies.size,
    )
  end

  def update_seat_booking(seat_selection, bus_seat_map)
    bus_seat_map.each do |seat_map|
      seat_map.each do |seat|
        if seat_selection.include?(seat['name']) && seat['status'] == Tour::BusInfo::OPEN
          seat['status'] = Tour::BusInfo::BOOKING
        end
      end
    end
  end

  def cal_date_of_cancellation(departure_date, tour_cancellation_details)
    departure_date - [tour_cancellation_details.max_by(&:flg1).flg1,
                      tour_cancellation_details.max_by(&:flg2).flg2].max
  end

  def update_use_point(user, tour, tour_order)
    received_bonus_point = tour.point_bonus_rate.present? ? tour_order.received_bonus_point : 0
    user.update!(
      point: user.point + received_bonus_point + tour_order.received_point,
    )
    earn_point_tour_order(user, tour, tour_order, received_bonus_point)
  end

  def earn_point_tour_order(user, tour, tour_order, received_bonus_point)
    user.point_usages.create!(
      module:         tour_order,
      received_point: received_bonus_point + tour_order.received_point,
      type_point:     tour.point_bonus_rate.present? ? PointUsage::BONUS : PointUsage::NORMAL,
      status:         PointUsage::ACCEPT,
    )
  end

  def number_bus(tour)
    tour.tour_bus_infos.size
  end

  def format_number_people(tour)
    tour.tour_orders&.size || 'なし'
  end

  def update_bus_infos_when_cancel(tour_order)
    select_seat = map_selected_seat(tour_order)
    tour_order.tour_bus_info.available_seats += tour_order.tour_order_accompanies.size
    tour_order.tour_bus_info.seats_map.each do |seats|
      seats.each do |seat|
        if select_seat.include?(seat['name'])
          seat.delete('full_name')
          seat['status'] = Tour::BusInfo::OPEN
        end
      end
    end
    tour_order.tour_bus_info.save!
  end

  def map_selected_seat(tour_order)
    tour_order.tour_order_accompanies.map do |tour_order_accompany|
      tour_order_accompany[:selected_seat]
    end
  end

  def refund_purchased_amount(tour_order, total_price, tour_cancellation_details) # rubocop:disable Metrics/PerceivedComplexity
    return unless tour_order.status == Tour::Order::BOOKED

    fee_and_refund_price = refund_price(tour_order, total_price, tour_cancellation_details)
    if fee_and_refund_price[:refund_price].round.zero?
      return update_tour_order(tour_order, fee_and_refund_price, nil)
    end

    if tour_order.payment_method == Tour::Order::BANK_TRANSFER ||
       tour_order.payment_method == Tour::Order::DIRECT_PAYMENT
      update_tour_order(tour_order, fee_and_refund_price, nil)
    end

    if tour_order.payment_status == Tour::Order::PENDING &&
       tour_order.payment_method == Tour::Order::CREDIT_CARD
      update_tour_order(tour_order, fee_and_refund_price, nil)
    end

    return unless tour_order.payment_status == Tour::Order::SUCCEEDED &&
                  tour_order.payment_method == Tour::Order::CREDIT_CARD

    purchased_id = tour_order.purchased_id
    if purchased_id
      refund = StripeService.refund_booking(purchased_id, 'requested_by_customer',
                                            fee_and_refund_price[:refund_price].round)
    end
    update_tour_order(tour_order, fee_and_refund_price, refund)
  end

  def update_tour_order(tour_order, fee_and_refund_price, refund)
    check_refund = check_refund(refund)
    cancellation_fee = nil
    price_refund = nil
    if tour_order.payment_status == Tour::Order::SUCCEEDED
      cancellation_fee = fee_and_refund_price[:fee_cancellation]
      price_refund = fee_and_refund_price[:refund_price]
    end
    tour_order.update!(
      status:               Tour::Order::CANCEL,
      date_of_cancellation: Date.today,
      cancellation_fee:     cancellation_fee,
      price_refund:         tour_order.is_cancellation_free.present? ? 0 : price_refund,
      payment_status:       check_refund[:payment_status],
      refund_comfirm_date:  check_refund[:refund_comfirm_date],
    )
  end

  def check_refund(refund)
    payment_status = nil
    refund_comfirm_date = nil
    if refund.present?
      payment_status = refund.status == Tour::Order::SUCCEEDED ? Tour::Order::REFUNED : Tour::Order::PENDING
      refund_comfirm_date = refund.status == Tour::Order::SUCCEEDED ? Date.today : nil
    else
      payment_status = Tour::Order::PENDING
    end
    { payment_status: payment_status, refund_comfirm_date: refund_comfirm_date }
  end

  def refund_price(tour_order, total_price, tour_cancellation_details)
    refund_price = total_price
    fee_cancellation = 0
    day_cancellation = (tour_order.tour_bus_info.departure_date - Date.today).to_i
    tour_cancellation_details.each do |tour_cancellation_detail|
      flg1 =  tour_cancellation_detail.flg1
      flg2 =  tour_cancellation_detail.flg2
      if flg1 > flg2
        if day_cancellation.between?(flg2, flg1)
          refund_price = total_price - (total_price * tour_cancellation_detail.value / 100)
          fee_cancellation = tour_cancellation_detail.value
        end
      elsif day_cancellation.between?(flg1, flg2)
        refund_price = total_price - (total_price * tour_cancellation_detail.value / 100)
        fee_cancellation = tour_cancellation_detail.value
      end
    end
    { refund_price: refund_price, fee_cancellation: fee_cancellation }
  end

  def cal_point_tour_order(tour_order, tour, total_detail, total_tour_order)
    return if tour.tax.blank?

    total_no_fax = (
      (
        total_detail[:initial_price] - total_detail[:tour_coupon]
      ) / BigDecimal((1 + (tour.tax.to_f / 100)).to_s).to_f
    )
    point_normal = (total_no_fax * tour.point_receive_rate.to_f / 100).to_i
    point_bonus = if tour_order.used_points.to_i < total_tour_order
                    (
                      (
                        total_no_fax - tour_order.used_points.to_i
                      ) * tour.point_bonus_rate.to_f / 100
                    ).to_i
                  else
                    0
                  end

    { point_bonus: point_bonus, point_normal: point_normal }
  end

  def update_tour_user_point(user, tour_order)
    decrement_point_tour_used!(tour_order, user)

    if tour_order.received_point.positive?
      user.point_usages.create!(
        module:         tour_order,
        received_point: tour_order.received_point,
        type_point:     PointUsage::NORMAL,
        status:         PointUsage::PENDING,
        start_date:     tour_order.departure_date + 10.days,
        end_date:       tour_order.departure_date + 10.days + tour_order.tour.exp_point_receive.to_i.months,
      )
    end

    return unless tour_order.received_bonus_point.positive?

    user.point_usages.create!(
      module:         tour_order,
      received_point: tour_order.received_bonus_point,
      type_point:     PointUsage::BONUS,
      status:         PointUsage::PENDING,
      start_date:     tour_order.departure_date + 10.days,
      end_date:       tour_order.departure_date + 10.days + tour_order.tour.exp_point_bonus.to_i.months,
    )
  end

  def decrement_point_tour_used!(tour_order, user)
    use_point = tour_order.used_points
    return if use_point <= 0

    user_point_normal = user.point
    user_point_bonus  = user.point_bonus
    total_price       = tour_order.initial_price - tour_order.coupon_discount
    bonus_point_use   = calc_bonus_point_tour_used(tour_order, use_point, total_price, user)
    normal_point_use  = calc_normal_point_tour_used(tour_order, use_point - bonus_point_use, bonus_point_use,
                                                    total_price, user)

    user.point        = user_point_normal - normal_point_use
    user.point_bonus  = user_point_bonus - bonus_point_use
    user.save!

    if normal_point_use.positive?
      user.point_usages.create!(module: tour_order, type_point: PointUsage::NORMAL,
                                used_point: normal_point_use)
    end
    return unless bonus_point_use.positive?

    user.point_usages.create!(module: tour_order, type_point: PointUsage::BONUS,
                              used_point: bonus_point_use)
  end

  def calc_normal_point_tour_used(_tour_order, use_point, bonus_point_use, total, user) # rubocop:disable Metrics/PerceivedComplexity
    return 0 if use_point.zero?

    normal_point = user.point
    return 0 unless normal_point.positive?

    total -= bonus_point_use

    if use_point.positive?
      use_point = total if use_point >= total
      if normal_point >= use_point
        use_point
      else
        normal_point
      end
    elsif normal_point >= total
      total
    else
      normal_point
    end
  end

  def calc_bonus_point_tour_used(_tour_order, use_point, total, user)
    bonus_point = user.point_bonus
    return 0 unless bonus_point.positive?

    if use_point.positive?
      use_point = total if use_point >= total
      if bonus_point >= use_point
        use_point
      else
        bonus_point
      end
    elsif bonus_point >= total
      total
    else
      bonus_point
    end
  end

  def tour_order_seat_price(tour)
    {
      first_row_seat_price: tour.first_row_seat_price,
      two_rows_seat_price:  tour.two_rows_seat_price,
      regular_seat_price:   tour.regular_seat_price,
    }
  end

  def send_email_to_user(_tour, tour_order)
    client = AwsSqsService.new

    title = "【STEP TRAVEL ツアーサービス】 #{tour_order.order_no}：予約が完了しました"
    # Send mail to orderer
    tour_order_accompany = tour_order.tour_order_accompanies.detect do |order_accompany|
      order_accompany.is_user.present? || order_accompany.is_owner.present?
    end

    return unless tour_order_accompany.email

    body = TourOrderMailer.with(tour_order:           tour_order,
                                tour_order_accompany: tour_order_accompany).mail_to_user.body.to_s.html_safe

    client.send('EMAIL', title, body, tour_order_accompany.email)
  end

  def tour_order_format_date_jp(value)
    case value.strftime('%a')
    when 'Mon'
      '月'
    when 'Tue'
      '火'
    when 'Wed'
      '水'
    when 'Thu'
      '木'
    when 'Fri'
      '金'
    when 'Sat'
      '土'
    when 'Sun'
      '日'
    else
      ''
    end
  end
end
