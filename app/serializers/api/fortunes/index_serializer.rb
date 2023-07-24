# frozen_string_literal: true

class Api::Fortunes::IndexSerializer < ApplicationSerializer
  attributes :today, :tomorrow

  def today
    object[:today].transform_keys do |k|
      Fortune.zodiacs.key(k.to_i)
    end.as_json
  end

  def tomorrow
    object[:tomorrow].transform_keys do |k|
      Fortune.zodiacs.key(k.to_i)
    end.as_json
  end
end
