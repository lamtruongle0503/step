# frozen_string_literal: true

class Admin::UserOperations::Show < ApplicationOperation
  def call
    authorize User

    @user = User.find(params[:id])
  end
end
