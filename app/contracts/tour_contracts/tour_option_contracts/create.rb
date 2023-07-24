# frozen_string_literal: true

class TourContracts::TourOptionContracts::Create < TourContracts::TourOptionContracts::Base
  validates :code, presence: true, uniqueness: { model: Tour::Option }
end
