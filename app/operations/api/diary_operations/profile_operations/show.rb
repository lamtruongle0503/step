# frozen_string_literal: true

class Api::DiaryOperations::ProfileOperations::Show < ApplicationOperation
  def call
    User.find(params[:id])
  end
end
