# frozen_string_literal: true

class Api::CreditOperations::Update < ApplicationOperation
  attr_reader :card_id

  def initialize(actor, params)
    super
    @card_id = params[:id]
  end

  def call
    update_credit_card!
  end

  private

  def update_credit_card!
    customer = Credit.find_by(user_id: actor.id)

    return unless customer

    StripeService.update_default_credit(customer.customer_id, card_id)
  end
end
