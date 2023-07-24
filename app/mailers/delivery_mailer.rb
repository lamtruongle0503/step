# frozen_string_literal: true

class DeliveryMailer < ApplicationMailer
  def completed
    @order = params[:order]
    mail(to: '', subject: '')
  end
end
