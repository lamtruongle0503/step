# frozen_string_literal: true

class Admin::Diaries::Users::MetaSerializer < ApplicationSerializer
  attributes %i[id nick_name full_name avatar]

  def full_name
    object.full_name
  end

  def avatar
    return unless object.asset

    Assets::AttributesSerializer.new(object.asset).as_json
  end
end
