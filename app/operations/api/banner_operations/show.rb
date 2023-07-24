# frozen_string_literal: true

class Api::BannerOperations::Show < ApplicationOperation
  def call
    Banner.find(params[:id])
  end
end
