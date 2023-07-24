# frozen_string_literal: true

class Api::DiaryOperations::MeOperations::ProfileOperations::Update < ApplicationOperation
  def call
    DiaryContracts::ProfileContracts::Update.new(profile_params).valid!
    ActiveRecord::Base.transaction do
      actor.update!(profile_params)
    end
  end

  private

  def profile_params
    params.permit(:nick_name)
  end
end
