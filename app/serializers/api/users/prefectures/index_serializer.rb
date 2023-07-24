# frozen_string_literal: true

class Api::Users::Prefectures::IndexSerializer < ApplicationSerializer
  attributes :id
  belongs_to :prefecture, serializer: Prefectures::AttributesSerializer
end
