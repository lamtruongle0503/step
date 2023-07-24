# frozen_string_literal: true

class Admin::LifeSupportOperations::RequestOperations::Destroy < ApplicationOperation
  attr_reader :request

  def initialize(actor, params)
    super
    @request = LifeSupport::Request.find(params[:id])
  end

  def call
    request.destroy!
  end
end
