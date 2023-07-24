# frozen_string_literal: true

class Admin::EcommerceOperations::CategoryOperations::Create < ApplicationOperation
  def call
    authorize nil, Ecommerces::CategoryPolicy

    EcommerceContracts::CategoryContracts::Create.new(category_params).valid!
    create_category!
  end

  private

  def create_category!
    Category.create!(category_params)
  end

  def category_params
    params.permit(:name).merge(code:    generate_code(Category.name),
                               ranking: generate_ranking(Category.name))
  end
end
