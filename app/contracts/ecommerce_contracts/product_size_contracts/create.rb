# frozen_string_literal: true

class EcommerceContracts::ProductSizeContracts::Create < EcommerceContracts::ProductSizeContracts::Base
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :remaining_count, presence:     true,
                              numericality: { greater_than_or_equal_to: 0 },
                              if:           -> { is_limit }
end
