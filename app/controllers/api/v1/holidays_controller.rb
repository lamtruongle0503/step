# frozen_string_literal: true

class Api::V1::HolidaysController < ApiV1Controller
  def index
    holidays = Api::HolidayOperations::Index.new(nil, params).call
    render json: holidays,
           each_serializer: Api::Holidays::IndexSerializer,
           meta: pagination_dict(holidays), root: 'data', adapter: :json
  end
end
