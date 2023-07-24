# frozen_string_literal: true

class Admin::Ecommerces::Campaigns::NotificationsController < ApiV1Controller
  before_action :authentication!

  def create
    render json:       Admin::EcommerceOperations::CampaignOperations::NotificationOperations::Create
      .new(actor, params).call,
           serializer: Admin::Ecommerces::Campaigns::Notifications::CreateSerializer
  end
end
