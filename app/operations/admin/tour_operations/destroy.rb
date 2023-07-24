# frozen_string_literal: true

class Admin::TourOperations::Destroy < ApplicationOperation
  def call
    authorize nil, TourPolicy

    tour = Tour.find(params[:id])
    ActiveRecord::Base.transaction do
      raise BadRequestError, tour: I18n.t('order_tours.tours.booked') if tour.tour_orders.present?

      tour.destroy!
    end
  end
end
