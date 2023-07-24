# frozen_string_literal: true

class Admin::Tours::OrderSpecials::Temporaries::ImportController < ApiV1Controller
  def create
    Admin::TourOperations::OrderSpecialOperations::TemporaryOperations::Create.new(actor, params).call
    render json: {}
  end
end
