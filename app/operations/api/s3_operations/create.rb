# frozen_string_literal: true

class Api::S3Operations::Create < ApplicationOperation
  def call
    { url: generate_put_signed_url }
  end

  private

  def generate_put_signed_url
    client = AwsS3Service.new
    client.generate_put_presigned_url(params[:key])
  end
end
