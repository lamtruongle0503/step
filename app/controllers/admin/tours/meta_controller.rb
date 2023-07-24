# frozen_string_literal: true

class Admin::Tours::MetaController < ApiV1Controller
  before_action :authentication!

  def index
    tours = Admin::TourOperations::MetaOperations::Index.new(actor, params).call
    render json: tours, each_serializer: Admin::Tours::Meta::IndexSerializer,
           root: 'data', adapter: :json
  end
end
