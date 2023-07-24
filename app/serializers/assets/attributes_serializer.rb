# frozen_string_literal: true

class Assets::AttributesSerializer < ApplicationSerializer
  attributes :id, :url, :type, :file_type
end
