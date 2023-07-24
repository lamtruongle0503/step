# frozen_string_literal: true

class Admin::Tours::OrderSpecials::SearchController < ApiV1Controller
  def index
    tour_orders = Admin::TourOperations::OrderSpecialOperations::SearchOperations::Index.new(actor,
                                                                                             params).call
    render json: tour_orders, each_serializer: Admin::Tours::OrderSpecials::Search::IndexSerializer,
           root: 'data', adapter: :json
  end
end
