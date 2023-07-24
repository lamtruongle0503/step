# frozen_string_literal: true

class Api::V1::Ecommerces::CampaignsController < ApiV1Controller
  def index
    campaigns = Api::EcommerceOperations::CampaignOperations::Index.new(nil, params).call
    render json: campaigns, each_serializer: Api::Ecommerces::Campaigns::IndexSerializer,
           meta: pagination_dict(campaigns), root: 'data', adapter: :json
  end

  def show
    render json: Api::EcommerceOperations::CampaignOperations::Show.new(nil, params).call,
           serializer: Api::Ecommerces::Campaigns::ShowSerializer, root: 'ecommerces'
  end
end
