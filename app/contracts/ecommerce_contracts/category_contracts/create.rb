# frozen_string_literal: true

class EcommerceContracts::CategoryContracts::Create < EcommerceContracts::CategoryContracts::Base
  validates :name, presence: true, uniqueness: { model: Category }

  validates :ranking, numericality: { only_integer: true }, uniqueness: { model: Category }
end
