# frozen_string_literal: true

class Admin::BannerOperations::Show < ApplicationOperation
  def call
    @banner = Banner.find(params[:id])
  end
end
