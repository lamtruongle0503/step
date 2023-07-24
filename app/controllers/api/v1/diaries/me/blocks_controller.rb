# frozen_string_literal: true

class Api::V1::Diaries::Me::BlocksController < ApiV1Controller
  def blocking
    blocking = Api::DiaryOperations::MeOperations::BlockOperations::Blocking.new(actor, params).call
    render json: blocking, each_serializer: Api::Diaries::Me::Blocks::BlockingSerializer,
           meta: pagination_dict(blocking), root: 'data', adapter: :json
  end

  def blocked
    blocked = Api::DiaryOperations::MeOperations::BlockOperations::Blocked.new(actor, params).call
    render json: blocked, each_serializer: Api::Diaries::Me::Blocks::BlockedSerializer,
           meta: pagination_dict(blocked), root: 'data', adapter: :json
  end
end
