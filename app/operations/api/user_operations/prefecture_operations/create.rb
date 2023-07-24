# frozen_string_literal: true

class Api::UserOperations::PrefectureOperations::Create < ApplicationOperation
  attr_reader :user, :current_password

  def initialize(actor, params)
    super
    @user = actor
  end

  def call
    UserContracts::PrefectureContracts::Create.new(
      user_prefecture_id,
    ).valid!
    user_prefecture = user.user_prefecture
    if user_prefecture
      user_prefecture.update!(prefecture_id: params[:prefecture_id])
    else
      user.create_user_prefecture(prefecture_id: params[:prefecture_id])
    end
  end

  private

  def user_prefecture_id
    params.permit(:prefecture_id)
  end
end
