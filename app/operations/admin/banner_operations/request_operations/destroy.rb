# frozen_string_literal: true

class Admin::BannerOperations::RequestOperations::Destroy < ApplicationOperation
  attr_reader :request

  def initialize(actor, params)
    super
    @request = Banner::Request.find(params[:id])
  end

  def call
    request.destroy!
  end
end
