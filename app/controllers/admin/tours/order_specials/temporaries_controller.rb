# frozen_string_literal: true

class Admin::Tours::OrderSpecials::TemporariesController < ApiV1Controller
  def index
    temporaries = Admin::TourOperations::OrderSpecialOperations::TemporaryOperations::Index.new(actor,
                                                                                                params).call
    render json: temporaries, each_serializer: Admin::Tours::OrderSpecials::Temporaries::IndexSerializer,
           root: 'data', meta: pagination_dict(temporaries), adapter: :json
  end

  def show
    temporary = Admin::TourOperations::OrderSpecialOperations::TemporaryOperations::Show.new(actor,
                                                                                             params).call
    render json: temporary, serializer: Admin::Tours::OrderSpecials::Temporaries::ShowSerializer
  end

  def update
    Admin::TourOperations::OrderSpecialOperations::TemporaryOperations::Update.new(actor, params).call
    render json: {}
  end

  def destroy
    Admin::TourOperations::OrderSpecialOperations::TemporaryOperations::Destroy.new(actor, params).call
    render json: {}
  end
end
