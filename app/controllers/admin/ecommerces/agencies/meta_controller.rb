# frozen_string_literal: true

class Admin::Ecommerces::Agencies::MetaController < ApiV1Controller
  before_action :authentication!

  def index
    agencies = Admin::EcommerceOperations::AgencyOperations::MetaOperations::Index
               .new(actor, params).call
    render json: agencies, each_serializer: Admin::Ecommerces::Agencies::Meta::IndexSerializer
  end
end
