# frozen_string_literal: true

class Admin::LifeSupportOperations::RequestOperations::Update < ApplicationOperation
  attr_reader :request

  def initialize(actor, params)
    super
    @request = LifeSupport::Request.find(params[:id])
  end

  def call
    if request.claim?
      request.update!(status: :sent)
    else
      request.update!(status: :claim)
    end
  end
end
