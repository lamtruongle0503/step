# frozen_string_literal: true

class EcommerceContracts::ProductContracts::StatusContracts::Base < ApplicationContract
  attribute :is_show, Boolean

  validates :is_show, inclusion: { in: [true, false] }
end
