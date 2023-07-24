# frozen_string_literal: true

class Api::Fortunes::AttributesSerializer < ApplicationSerializer
  attributes :id, :fortune_type, :title, :sign, :param, :image, :text, :rank, :color, :item, :date
end
