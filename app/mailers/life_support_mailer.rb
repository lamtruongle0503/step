# frozen_string_literal: true

class LifeSupportMailer < ApplicationMailer
  def notify_to_admin
    @request = params[:request]
    mail(to: '', subject: '')
  end
end
