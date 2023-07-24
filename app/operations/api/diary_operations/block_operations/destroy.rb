# frozen_string_literal: true

class Api::DiaryOperations::BlockOperations::Destroy < ApplicationOperation
  def call
    actor.user_blocks.find_by!(blocked_id: params[:id]).destroy!
  end
end
