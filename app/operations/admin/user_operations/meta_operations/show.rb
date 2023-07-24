# frozen_string_literal: true

class Admin::UserOperations::MetaOperations::Show < ApplicationOperation
  def call
    User.find_by!(phone_number: params[:phone_number])
  end
end
