# frozen_string_literal: true

class Admin::EcommerceOperations::CategoryOperations::Update < ApplicationOperation
  attr_reader :category

  def initialize(actor, params)
    super

    @category = Category.find(params[:id])
  end

  def call
    authorize nil, Ecommerces::CategoryPolicy

    ActiveRecord::Base.transaction do
      update_category!
      upload(category) if params[:file]
    end
    category
  end

  private

  def update_category!
    EcommerceContracts::CategoryContracts::Update.new(category_params).valid!
    category.update!(category_params)
  end

  def category_params
    params.permit(:name)
  end

  def upload(category)
    upload_file(category, params[:file][:url], params[:file][:type], params[:file][:file_type])
  end
end
