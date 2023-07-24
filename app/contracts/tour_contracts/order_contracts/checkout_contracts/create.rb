# frozen_string_literal: true

class TourContracts::OrderContracts::CheckoutContracts::Create < ApplicationContract
  attribute :record,          Order
  attribute :user,            User
  attribute :payment_method,  String

  validates :payment_method, presence: true

  validate :only_use_credit_card_or_bank_transfer, if: -> { payment_method }
  validate :status_must_pending
  validate :must_has_credit_card, if: -> { use_credit? }
  validate :tour_must_be_available

  def status_must_pending
    current_status = record.status
    return if Tour::Order::CONFIRM == current_status

    errors.add :status,
               I18n.t('order_tours.must_be_confirm')
  end

  def must_has_credit_card
    customer_id = user.credit&.customer_id
    return errors.add :credit, I18n.t(:not_registered, scope: :credit) if customer_id.blank?

    list_cards = StripeService.get_list_credit_card(customer_id)
    errors.add :credit, I18n.t('orders.must_has_credit_card') if list_cards.blank?
  end

  def use_credit?
    Tour::Order::CREDIT_CARD == payment_method
  end

  def only_use_credit_card_or_bank_transfer
    return if [Tour::Order::CREDIT_CARD, Tour::Order::BANK_TRANSFER].include?(payment_method)

    errors.add :payment_method, I18n.t('orders.only_use_credit_card_or_bank_transfer')
  end

  def tour_must_be_available
    return if Date.today.between?(record.tour.start_date, record.tour.end_date)

    errors.add(:tour,
               I18n.t('order_tours.tour.must_be_available'))
  end
end
