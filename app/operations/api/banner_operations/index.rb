# frozen_string_literal: true

class Api::BannerOperations::Index < ApplicationOperation
  def call
    @q = Banner.ransack(params[:q])
    @q.result.available.setting_show.includes(:assets).newest.page(params[:page])
  end
end
