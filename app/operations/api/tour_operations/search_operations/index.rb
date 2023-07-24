# frozen_string_literal: true

class Api::TourOperations::SearchOperations::Index < ApplicationOperation
  attr_reader :tour_stay, :tour_inday

  def initialize(actor, params)
    super
    @user_prefecture = ZipCodeJp.find(actor.post_code)&.prefecture
    @tour_stay = Tour.by_end_date_and_status_posted.by_prefecture_name(Tour::STAY, @user_prefecture)
    @tour_inday = Tour.by_end_date_and_status_posted.by_prefecture_name(Tour::INDAY, @user_prefecture)
  end

  def call
    Kaminari.paginate_array(
      tour_stay.newest.ransack(params[:q]).result(distinct: true) +
      tour_inday.newest.ransack(params[:q]).result(distinct: true) +
      Tour.by_end_date_and_status_posted.includes(
        :assets, :tour_information, :tour_category
      ).newest.ransack(params[:q]).result(distinct: true) +
      Hotel.includes(:assets).newest.ransack(params[:q]).result(distinct: true),
    ).page(params[:page])
  end
end
