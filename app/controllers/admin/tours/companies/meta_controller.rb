# frozen_string_literal: true

class Admin::Tours::Companies::MetaController < ApiV1Controller
  before_action :authentication!

  def index
    tour_companies = Admin::TourOperations::CompanyOperations::MetaOperations::Index.new(actor, params).call
    render json: tour_companies,
           each_serializer: Admin::Tours::Companies::Meta::IndexSerializer,
           root: 'data', adapter: :json
  end
end
