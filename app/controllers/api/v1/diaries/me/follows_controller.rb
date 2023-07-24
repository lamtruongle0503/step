# frozen_string_literal: true

class Api::V1::Diaries::Me::FollowsController < ApiV1Controller
  def following
    following = Api::DiaryOperations::MeOperations::FollowOperations::Following.new(actor, params).call
    render json: following, each_serializer: Api::Diaries::Me::Follows::FollowingSerializer,
           meta: pagination_dict(following), root: 'data', adapter: :json
  end

  def followed
    followed = Api::DiaryOperations::MeOperations::FollowOperations::Followed.new(actor, params).call
    render json: followed, each_serializer: Api::Diaries::Me::Follows::FollowedSerializer,
           meta: pagination_dict(followed), root: 'data', adapter: :json
  end

  def destroy
    Api::DiaryOperations::MeOperations::FollowOperations::Destroy.new(actor, params).call
    render json: {}
  end
end
