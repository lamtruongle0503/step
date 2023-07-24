# frozen_string_literal: true

class Api::V1::HealthsController < ApiV1Controller
  def index
    render json: {}, status: :ok
  end
end
