# frozen_string_literal: true

class Api::Users::IndexSerializer < ApplicationSerializer
  attributes :id, :nick_name, :first_name, :last_name, :first_name_kana, :last_name_kana

  has_one :asset, serializer: Assets::AttributesSerializer
end
