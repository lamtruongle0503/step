# frozen_string_literal: true

class BannerMailer < ApplicationMailer
  def notify_to_admin
    @request = params[:request]
    mail(to: '', subject: '')
  end
end
