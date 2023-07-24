# frozen_string_literal: true

class Admin::Tours::Managements::ImportsController < ApiV1Controller
  before_action :authentication!

  def create
    Admin::TourOperations::ManagementOperations::ImportOperations::Create.new(actor, params).call

    render json: {}
  end
end
