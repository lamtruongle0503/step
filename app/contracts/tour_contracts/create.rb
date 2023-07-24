# frozen_string_literal: true

class TourContracts::Create < TourContracts::Base
  validates :code, presence: true, uniqueness: { model: Tour }
end
