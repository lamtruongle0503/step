# frozen_string_literal: true

class Api::V1::Diaries::WelcomeController < ApiV1Controller
  before_action :authentication!

  def create
    Api::DiaryOperations::WelcomeOperations::Create.new(actor, params).call
    render json: {}
  end
end
