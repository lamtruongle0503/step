# frozen_string_literal: true

class Api::V1::Diaries::ProfilesController < ApiV1Controller
  before_action :authentication!

  def show
    user = Api::DiaryOperations::ProfileOperations::Show.new(actor, params).call
    render json: user, serializer: Api::Diaries::Profiles::ShowSerializer, actor: actor
  end

  def following
    following = Api::DiaryOperations::ProfileOperations::Following.new(actor, params).call
    render json: following, each_serializer: Api::Diaries::Profiles::FollowingSerializer, actor: actor,
           meta: pagination_dict(following), root: 'data', adapter: :json
  end

  def followed
    followed = Api::DiaryOperations::ProfileOperations::Followed.new(actor, params).call
    render json: followed, each_serializer: Api::Diaries::Profiles::FollowedSerializer, actor: actor,
           meta: pagination_dict(followed), root: 'data', adapter: :json
  end
end
