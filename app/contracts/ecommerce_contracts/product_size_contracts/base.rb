# frozen_string_literal: true

class EcommerceContracts::ProductSizeContracts::Base < ApplicationContract
  attribute :name,            String
  attribute :price,           Float
  attribute :remaining_count, Integer
  attribute :is_limit,        Boolean
end
