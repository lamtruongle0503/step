# frozen_string_literal: true

require 'csv'

class Admin::EcommerceOperations::ProductOperations::DownloadOperations::Create < ApplicationOperation
  def call
    generate_csv
  end

  private

  def products
    @q = Product.includes(:category, :assets, :product_sizes).ransack(params[:q])
    @q.result(distinct: true).newest
  end

  def generate_csv
    CSV.generate do |csv|
      csv << I18n.t(:products, scope: [:headers])
      products.each_with_index do |record, index|
        csv << [index + 1, record.name, record.category.name, format_sizes(record),
                format_price_sizes(record), format_discount(record.discount),
                accessibility(record.is_show)]
      end
    end
  end
end
