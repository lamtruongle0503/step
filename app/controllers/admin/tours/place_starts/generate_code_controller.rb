# frozen_string_literal: true

class Admin::Tours::PlaceStarts::GenerateCodeController < ApiV1Controller
  before_action :authentication!

  def create
    code = Admin::TourOperations::PlaceStartOperations::GenerateCodeOperations::Create.new(actor, params).call

    render json: code
  end
end
