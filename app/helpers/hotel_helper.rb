# frozen_string_literal: true

module HotelHelper # rubocop:disable Metrics/ModuleLength
  def sum_price_person_for_room(obj, date_checkin, number_night, number_person) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/AbcSize, Metrics/MethodLength
    room_setting = obj.select { |o| o.date == date_checkin.to_date }.first
    case number_person
    when 1
      return 0 unless room_setting&.one_person_fee

      (room_setting.one_person_fee * number_night * number_person)&.round
    when 2
      return 0 unless room_setting&.two_people_fee

      (room_setting.two_people_fee * number_night * number_person)&.round
    when 3
      return 0 unless room_setting&.three_people_fee

      (room_setting.three_people_fee * number_night * number_person)&.round
    when 4
      return 0 unless room_setting&.four_people_fee

      (room_setting.four_people_fee * number_night * number_person)&.round
    when 5
      return 0 unless room_setting&.five_people_fee

      (room_setting.five_people_fee * number_night * number_person)&.round
    when 6
      return 0 unless room_setting&.six_person_fee

      (room_setting.six_person_fee * number_night * number_person)&.round
    when 7
      return 0 unless room_setting&.seven_person_fee

      (room_setting.seven_person_fee * number_night * number_person)&.round
    when 8
      return 0 unless room_setting&.eight_person_fee

      (room_setting.eight_person_fee * number_night * number_person)&.round
    when 10
      return 0 unless room_setting&.ten_person_fee

      (room_setting.ten_person_fee * number_night * number_person)&.round
    else
      0
    end
  end

  def sum_price_option(object, price_room, total_room)
    price_option = 0
    object.map do |obj|
      price_option += if obj.unit == Hotel::Option::JPY
                        obj.price * total_room
                      else
                        (obj.price / 100) * price_room
                      end
    end
    price_option&.round
  end

  def price_childrens(objects, room_price, params_childrens, _params_adults, total_room, number_night) # rubocop:disable Metrics/ParameterLists
    price_children = 0
    objects.each do |obj|
      next unless (params_childrens[obj.code]).positive?

      price = if obj.unit == Hotel::Option::JPY
                obj.fee * params_childrens[obj.code] * number_night * total_room
              else
                room_price * (obj.fee.to_f / 100)
              end

      price_children += price
    end

    price_children&.round
  end

  def price_sale_off(objects, days, price_room)
    sale_off = objects.map do |item|
      JSON.parse(item.gsub('=>', ':'))
    end
    option = sale_off.select { |obj| obj['day'] == days }

    return 0 unless option.present?

    price_sale = (option[0]['percent'].to_f / 100) * price_room
    price_sale&.round
  end

  def payment_hotel(customer_id, total_price, description, card_id)
    StripeService.payment_with_card(
      customer_id, total_price, description, card_id
    )
  end

  def send_mail_hotel_request(request)
    client = AwsSqsService.new

    title = '【STEPトラベルからのお知らせ】リクエスト予約のメール'
    body_mail_hotel = HotelRequestMailer.notify_to_hotel(request).body.to_s.html_safe
    body_mail_user = HotelRequestMailer.notify_to_user(request).body.to_s.html_safe
    client.send('EMAIL', title, body_mail_hotel, request.hotel.email)
    client.send('EMAIL', title, body_mail_user, request.email)
  end

  def hotel_status(status)
    case status
    when Hotel::POSTING
      '掲載中'
    when Hotel::ENDED
      '掲載停止'
    end
  end

  def total_order(order)
    price_coupon = order.coupon ? order.coupon.price : 0
    (order.total + order.used_points.to_i + price_coupon).round
  end

  def format_rereservation_payment(method)
    case method
    when Hotel::Order::CREDIT_CARD
      'クレジット決済'
    when Hotel::Order::ON_SPOT
      '現地決済'
    else
      '全て'
    end
  end

  def format_status_hotel_order(status)
    case status
    when Hotel::Order::REQUESTING
      'リクエスト中'
    when Hotel::Order::CONFIRMING_CUSTOMER
      'お客様確認中'
    when Hotel::Order::RESERVE
      '予約中'
    when Hotel::Order::STAYED
      '宿泊済'
    when Hotel::Order::CANCEL_ALREADY
      'キャンセル済'
    else
      ''
    end
  end

  def format_date_jp(value)
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

  def type_room_jp(name)
    case name.to_s
    when 'single'
      'シングル'
    when 'double'
      'ダブル'
    when 'twin'
      'ツイン'
    when 'double_twin'
      'ツイン (2ベッドルーム)'
    else
      ''
    end
  end

  # CALC COST HOTEL
  def calc_price_room(room_settings, check_in, number_night, adult_total, total_room)
    return raise BadRequestError, room_settings: I18n.t('models.can_not_blank') if room_settings.blank?

    adult_total_one_room = adult_total / total_room
    one_room = sum_price_person_for_room(room_settings, check_in, number_night, adult_total_one_room)
    one_room * total_room.to_i
  end

  def calc_price_options(option_ids, room_price, total_room)
    return 0 unless option_ids.present?

    hotel_options = Hotel::Option.where(id: option_ids)
    return 0 unless hotel_options.present?

    sum_price_option(hotel_options, room_price, total_room)
  end

  def calc_price_childrens(object, room_price, params_childrens, adult_total, total_room, number_night) # rubocop:disable Metrics/ParameterLists
    return 0 if object.setting_children == Hotel::Plan::IMPOSSIBLE

    children_ids = object.hotel_plan_childrens.pluck(:hotel_children_info_id)
    hotel_childrens = Hotel::ChildrenInfo.where(id: children_ids)
    return 0 unless hotel_childrens.present?

    price_childrens(hotel_childrens, room_price, params_childrens, adult_total, total_room, number_night)
  end

  def calc_price_sale_off_stay_nights(object, number_night, room_price)
    return 0 if object.is_sale_off == Hotel::Plan::NO_SET

    price_sale_off(object.setting_sale_off, number_night, room_price)
  end

  def send_mail_booking(hotel_order)
    client = AwsSqsService.new

    title = "【STEP TRAVEL ホテル予約】#{hotel_order.order_no}：予約を受け付けました"
    body = HotelReservationMailer.with(hotel_order: hotel_order).notify_to_user.body.to_s.html_safe

    client.send('EMAIL', title, body, hotel_order.user.email) if hotel_order.user&.email
    client.send('EMAIL', title, body, hotel_order.user.email) if hotel_order.user_contact&.email
  end

  def send_mail_cancel(hotel_order)
    client = AwsSqsService.new

    title = "【STEP TRAVEL ホテル予約】#{hotel_order.order_no}：キャンセルしました"
    body = CancelHotelReservationMailer.with(hotel_order: hotel_order).notify_to_hotel.body.to_s.html_safe
    body_to_user = CancelHotelReservationMailer.with(hotel_order: hotel_order)
                                               .notify_to_user.body.to_s.html_safe

    # Send maid to hotel
    client.send('EMAIL', title, body, hotel_order.hotel.email)
    # Send mail to user
    client.send('EMAIL', title, body_to_user, hotel_order.user.email) if hotel_order.user&.email
    return unless hotel_order.user_contact&.email

    # Send mail to user contact
    client.send('EMAIL', title, body_to_user, hotel_order.user_contact.email)
  end
end
