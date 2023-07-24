# frozen_string_literal: true

require 'hotel/option'
class Admin::HotelOperations::OptionOperations::Destroy < ApplicationOperation
  def call
    authorize nil, Hotel::OptionPolicy

    ActiveRecord::Base.transaction do
      Hotel::Option.find(params[:id])&.destroy
    end
  end
end
