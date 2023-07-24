# frozen_string_literal: true

class HotelRequestMailer < ActionMailer::Base
  include HotelHelper
  def notify_to_hotel(request)
    @request = request
    @day_of_week = format_date_jp(@request.check_in.to_date)
    mail(to: '', subject: '')
  end

  def notify_to_user(request)
    @request = request
    @day_of_week = format_date_jp(@request.check_in.to_date)
    mail(to: '', subject: '')
  end
end
