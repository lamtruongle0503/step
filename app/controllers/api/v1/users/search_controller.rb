# frozen_string_literal: true

class Api::V1::Users::SearchController < ApiV1Controller
  before_action :authentication!

  def index
    users = Api::UserOperations::SearchOperations::Index.new(actor, params).call
    render json: users, each_serializer: Api::Users::Searchs::IndexSerializer, actor: actor,
           meta: pagination_dict(users), root: 'data', adapter: :json
  end
end
