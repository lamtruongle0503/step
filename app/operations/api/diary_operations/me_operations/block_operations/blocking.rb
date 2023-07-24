# frozen_string_literal: true

class Api::DiaryOperations::MeOperations::BlockOperations::Blocking < ApplicationOperation
  def call
    @blocking = actor.user_blocks.includes(user_blocker: :asset).newest.page(params[:page])
  end
end
