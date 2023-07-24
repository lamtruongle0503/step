# frozen_string_literal: true

class CodeContracts::Create < ApplicationContract
  CODE_MODEL = [Tour.name, User.name, Product.name, Contact.name, Category.name, Order.name,
                Campaign.name, Tour::Order.name, Hotel::Order.name, Agency.name].freeze

  attribute :name_model, String

  validates :name_model, presence: true, inclusion: { in: CODE_MODEL }
end
