# frozen_string_literal: true

class Admin::BannerOperations::RequestOperations::Index < ApplicationOperation
  def call
    @q = Banner::Request.includes(banner: [prefectures: :area_setting]).ransack(params[:q])
    @q.result.newest.page(params[:page])
  end
end
