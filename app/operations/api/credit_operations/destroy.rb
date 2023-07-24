# frozen_string_literal: true

class Api::CreditOperations::Destroy < ApplicationOperation
  attr_reader :card_id, :customer

  def initialize(actor, params)
    super
    @card_id = params[:id]
    @customer = Credit.find_by(user_id: actor.id)
  end

  def call
    delete_credit_card!
    update_default_card!
  end

  private

  def delete_credit_card!
    return unless customer

    StripeService.delete_card(customer.customer_id, card_id)
  end

  def update_default_card!
    default_card = StripeService.get_default_credit(customer.customer_id)
    return if default_card.present?

    list_cards = StripeService.get_list_credit_card(customer.customer_id)

    return unless list_cards.any?

    card_default_id = list_cards[0].first.first
    StripeService.update_default_credit(customer.customer_id, card_default_id)
  end
end
