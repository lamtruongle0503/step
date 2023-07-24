# frozen_string_literal: true

class Admin::BannerOperations::Destroy < ApplicationOperation
  def call
    banner = Banner.find(params[:id])
    banner.destroy!
  end
end
