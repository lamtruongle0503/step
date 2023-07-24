# frozen_string_literal: true

class Admin::PrefectureOperations::Index < ApplicationOperation
  def call
    Prefecture.all
  end
end
