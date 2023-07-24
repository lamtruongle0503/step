# frozen_string_literal: true

class EcommerceContracts::CategoryContracts::Update < EcommerceContracts::CategoryContracts::Base
  validates :name, presence: true, uniqueness: { model: Category }, unless: -> { name.nil? }
end
