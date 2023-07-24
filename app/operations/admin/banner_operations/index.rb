# frozen_string_literal: true

class Admin::BannerOperations::Index < ApplicationOperation
  def call
    @q = Banner.ransack(params[:q])
    @q.result.includes(:assets).newest.page(params[:page])
  end
end
