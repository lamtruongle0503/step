# frozen_string_literal: true

class Api::PrefectureOperations::Index < ApplicationOperation
  def call
    Prefecture.all
  end
end
