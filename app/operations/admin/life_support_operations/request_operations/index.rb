# frozen_string_literal: true

class Admin::LifeSupportOperations::RequestOperations::Index < ApplicationOperation
  def call
    @q = LifeSupport::Request.includes(life_support: [prefectures: :area_setting]).ransack(params[:q])
    @q.result.newest.page(params[:page])
  end
end
