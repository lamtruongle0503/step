# frozen_string_literal: true

class Api::V1::S3Controller < ApiV1Controller
  before_action :authentication!

  def create
    render json: Api::S3Operations::Create.new(actor, params).call,
           serializer: Api::S3::CreateSerializer, root: 's3'
  end
end
