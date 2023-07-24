# frozen_string_literal: true

class Api::Diaries::Users::MetaSerializer < ApplicationSerializer
  attributes %i[id nick_name avatar]

  def avatar
    return unless object.asset

    Assets::AttributesSerializer.new(object.asset).as_json
  end
end
