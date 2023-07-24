# frozen_string_literal: true

class Api::UserOperations::PrefectureOperations::Index < ApplicationOperation
  def call
    actor.user_prefecture
  end
end
