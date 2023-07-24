# frozen_string_literal: true

class Admin::PaymentOperations::Index < ApplicationOperation
  def call
    Payment.all
  end
end
