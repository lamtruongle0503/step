# frozen_string_literal: true

class Api::V1::Diaries::FollowsController < ApiV1Controller
  before_action :authentication!

  def create
    Api::DiaryOperations::FollowOperations::Create.new(actor, params).call
    render json: {}
  end

  def destroy
    Api::DiaryOperations::FollowOperations::Destroy.new(actor, params).call
    render json: {}
  end
end
