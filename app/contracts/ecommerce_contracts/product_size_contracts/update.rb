# frozen_string_literal: true

class EcommerceContracts::ProductSizeContracts::Update < EcommerceContracts::ProductSizeContracts::Base
  attribute :id,       Integer
  attribute :_destroy, String

  validates :price, presence: true, numericality: { greater_than: 0 }, if: -> { id.blank? }
  validates :remaining_count, presence:     true,
                              numericality: { greater_than_or_equal_to: 0 },
                              if:           -> { is_limit }
end
