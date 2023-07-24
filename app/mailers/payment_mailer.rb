# frozen_string_literal: true

class PaymentMailer < ApplicationMailer
  def mail_to_user
    @order = params[:order]
    mail(to: '', subject: '')
  end

  def mail_to_agency
    @order = params[:order]
    mail(to: '', subject: '')
  end
end
