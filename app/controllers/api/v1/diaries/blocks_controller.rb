# frozen_string_literal: true

class Api::V1::Diaries::BlocksController < ApiV1Controller
  before_action :authentication!

  def create
    Api::DiaryOperations::BlockOperations::Create.new(actor, params).call
    render json: {}
  end

  def destroy
    Api::DiaryOperations::BlockOperations::Destroy.new(actor, params).call
    render json: {}
  end
end
