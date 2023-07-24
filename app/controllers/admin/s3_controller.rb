# frozen_string_literal: true

class Admin::S3Controller < ApiV1Controller
  before_action :authentication!

  def create
    render json: Admin::S3Operations::Create.new(actor, params).call,
           serializer: Admin::S3::CreateSerializer, root: 's3'
  end
end
