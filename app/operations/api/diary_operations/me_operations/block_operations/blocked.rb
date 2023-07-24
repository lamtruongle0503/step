# frozen_string_literal: true

class Api::DiaryOperations::MeOperations::BlockOperations::Blocked < ApplicationOperation
  def call
    @blocked = UserBlock.user_blocked(actor.id).includes(user_blocked: :asset).newest.page(params[:page])
  end
end
