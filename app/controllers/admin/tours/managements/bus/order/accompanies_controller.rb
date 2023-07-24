# frozen_string_literal: true

class Admin::Tours::Managements::Bus::Order::AccompaniesController < ApiV1Controller
  before_action :authentication!

  def update
    Admin::TourOperations::BusInfoOperations::OrderOperations::AccompanyOperations::Update.new(actor,
                                                                                               params).call
    render json: {}
  end
end
