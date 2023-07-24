# frozen_string_literal: true

class Api::V1::Ecommerces::Campaigns::MetaController < ApiV1Controller
  before_action :authentication!

  def index
    campaigns = Api::EcommerceOperations::CampaignOperations::MetaOperations::Index
                .new(actor, params).call
    render json: campaigns, each_serializer: Api::Ecommerces::Campaigns::Meta::IndexSerializer
  end
end
