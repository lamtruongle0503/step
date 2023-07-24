# frozen_string_literal: true

class Admin::TourOperations::OrderSpecialOperations::TemporaryOperations::Update < ApplicationOperation
  def initialize(actor, params)
    super
    @tour = Tour.find(params[:tour_id])
    @order_special = @tour.tour_order_specials.find(params[:order_special_id])
    @temporary = Tour::Temporary.find(params[:id])
  end

  def call
    ActiveRecord::Base.transaction do
      @temporary.update!(temporary_params)
    end
  end

  private

  def temporary_params
    params.permit(:name, :furigana, :postal_code, :address1, :address2,
                  :telephone, :phone_number, :age, :gender)
  end
end
