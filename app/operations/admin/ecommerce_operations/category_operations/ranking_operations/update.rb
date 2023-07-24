# frozen_string_literal: true

class Admin::EcommerceOperations::CategoryOperations::RankingOperations::Update < ApplicationOperation
  def call
    EcommerceContracts::CategoryContracts::RankingContracts::Create.new(category_params).valid!
    ActiveRecord::Base.transaction do
      update_categories!
    end
  end

  private

  def category_params
    params.permit(category_attributes: %i[id ranking])
  end

  def update_categories!
    category_ids = params[:category_attributes].pluck(:id)
    id_categories = Category.find(category_ids).index_by(&:id)
    category_params[:category_attributes].each do |category_param|
      category = id_categories[category_param[:id].to_i]
      category.update!(category_param)
    end
  end
end
