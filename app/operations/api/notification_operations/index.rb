# frozen_string_literal: true

class Api::NotificationOperations::Index < ApplicationOperation
  def call
    actor.notifications.newest.includes(:asset, :module, :point_usage).page(params[:page])
  end
end
