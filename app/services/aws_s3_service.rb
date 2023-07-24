# frozen_string_literal: true

class AwsS3Service
  attr_reader :s3_client

  def initialize
    @s3_client = Aws::S3::Presigner.new
  end

  def generate_put_presigned_url(key)
    s3_client.presigned_url(:put_object, bucket: ENV['AWS_BUCKET'], key: key)
  end
end
