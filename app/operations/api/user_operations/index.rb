# frozen_string_literal: true

class Api::UserOperations::Index < ApplicationOperation
  def call
    User.all
  end
end
