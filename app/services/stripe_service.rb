# frozen_string_literal: true

class StripeService
  INVALID_CARD_CODE = %w[invalid_cvc invalid_number invalid_expiry_month
                         invalid_expiry_year invalid_card_type card_declined
                         card_decline_rate_limit_exceeded expired_card incorrect_zip
                         incorrect_address incorrect_cvc incorrect_number].freeze
  class << self
    def create_customer(user)
      Stripe::Customer.create({
                                phone: user.phone_number,
                                email: user.email.to_s,
                              })
    end

    def create_credit_card(customer_id, user_name, card_number, exp_month, exp_year, cvc) # rubocop:disable Metrics/ParameterLists
      Stripe::Customer.create_source(
        customer_id, {
          source: {
            object:    'card',
            name:      user_name,
            number:    card_number,
            exp_month: exp_month,
            exp_year:  exp_year,
            cvc:       cvc,
          },
        }
      )
    rescue StandardError => e
      raise BadRequestError, e.message
    end

    def get_list_credit_card(customer_id)
      Stripe::Customer.list_sources(customer_id).data.map do |s|
        { s.id => s.last4, exp_date: "#{s.exp_month.to_s.rjust(2, '0')}/#{s.exp_year.to_s.last(2)}" }
      end
    end

    def get_default_credit(customer_id)
      Stripe::Customer.retrieve(customer_id).invoice_settings.default_payment_method
    end

    def update_default_credit(customer_id, card_id)
      Stripe::Customer.update(customer_id,
                              { invoice_settings: { default_payment_method: card_id } })
    end

    def delete_card(customer_id, card_id)
      Stripe::Customer.delete_source(
        customer_id,
        card_id,
      )
    end

    def payment(customer_id, amount, description)
      Stripe::Charge.create({
                              amount:      amount,
                              currency:    'jpy',
                              description: description,
                              customer:    customer_id,
                            })
    rescue StandardError => e
      case e.code
      when 'invalid_charge_amount'
        raise BadRequestError, I18n.t('orders.invalid_charge_amount')
      when *INVALID_CARD_CODE
        raise BadRequestError, I18n.t('orders.invalid_credit_card')
      when 'amount_too_small'
        raise BadRequestError, message: I18n.t('orders.amount_too_small')
      else
        raise BadRequestError, I18n.t('orders.invalid_checkout')
      end
    end

    def refund(purchased_id, reason)
      Stripe::Refund.create({
                              charge: purchased_id,
                              reason: reason,
                            })
    end

    def refund_booking(purchased_id, reason, total)
      Stripe::Refund.create({
                              charge: purchased_id,
                              reason: reason,
                              amount: total,
                            })
    end

    def payment_with_card(customer_id, amount, description, card_id)
      Stripe::Charge.create({
                              amount:      amount,
                              currency:    'jpy',
                              description: description,
                              customer:    customer_id,
                              source:      card_id,
                            })
    rescue StandardError => e
      raise BadRequestError, e.message
    end
  end
end
