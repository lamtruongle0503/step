# frozen_string_literal: true

class Admin::UserOperations::Index < ApplicationOperation
  def call
    authorize User
    User.newest.search_by(params[:q]).page(params[:page])
  end
end
