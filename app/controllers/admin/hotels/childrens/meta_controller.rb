# frozen_string_literal: true

class Admin::Hotels::Childrens::MetaController < ApiV1Controller
  before_action :authentication!

  def index
    hotel_childrens = Admin::HotelOperations::ChildrenOperations::MetaOperations::Index.new(actor,
                                                                                            params).call
    render json: hotel_childrens,
           each_serializer: Admin::Hotels::Childrens::Meta::IndexSerializer,
           root: 'data', adapter: :json
  end
end
