# frozen_string_literal: true

class Admin::Tours::Categories::MetaController < ApiV1Controller
  before_action :authentication!

  def index
    tour_categories = Admin::TourOperations::CategoryOperations::MetaOperations::Index.new(actor, params).call
    render json: tour_categories,
           each_serializer: Admin::Tours::Categories::Meta::IndexSerializer,
           root: 'data', adapter: :json
  end
end
