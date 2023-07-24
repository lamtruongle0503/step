# frozen_string_literal: true

class Api::Hotels::Rankings::IndexSerializer < ApplicationSerializer
  attributes :id, :name, :pr_desc, :min_price, :image

  def min_price
    object.hotel_room_settings
          .where('date >= ?', Time.zone.now.to_date)
          .pluck(:two_people_fee)
          .reject(&:zero?)
          .min
  end

  def image
    object.assets.detect { |asset_image| asset_image.type == Asset::H_IMAGE_INTRO }
  end
end
