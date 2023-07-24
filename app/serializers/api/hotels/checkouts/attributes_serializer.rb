# frozen_string_literal: true

class Api::Hotels::Checkouts::AttributesSerializer < ApplicationSerializer
  attributes :accompany_id, :payment_method, :payment_status

  def accompany_id
    object[:accompany_id]
  end

  def payment_method
    object[:payment_method]
  end

  def payment_status
    object[:payment_status]
  end
end
