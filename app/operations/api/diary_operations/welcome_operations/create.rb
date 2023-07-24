# frozen_string_literal: true

class Api::DiaryOperations::WelcomeOperations::Create < ApplicationOperation
  def call
    actor.update!(diary_flg: true)
  end
end
