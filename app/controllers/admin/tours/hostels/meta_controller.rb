# frozen_string_literal: true

class Admin::Tours::Hostels::MetaController < ApiV1Controller
  before_action :authentication!

  def index
    tour_hostels = Admin::TourOperations::HostelOperations::MetaOperations::Index.new(actor, params).call
    render json: tour_hostels,
           each_serializer: Admin::Tours::Hostels::Meta::IndexSerializer,
           root: 'data', adapter: :json
  end
end
