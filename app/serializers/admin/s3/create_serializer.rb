# frozen_string_literal: true

class Admin::S3::CreateSerializer < ApplicationSerializer
  attribute :url

  def url
    object[:url]
  end
end
