# frozen_string_literal: true

class Api::News::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :published_at, :title, :url, :url_to_image, :author, :content, :description
end
