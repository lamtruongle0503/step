# frozen_string_literal: true

class Api::V1::FortunesController < ApiV1Controller
  # before_action :authentication!

  def index
    render json: Api::FortuneOperations::Index.new(nil, params).call,
           serializer: Api::Fortunes::IndexSerializer, root: 'fortunes'
  end
end
