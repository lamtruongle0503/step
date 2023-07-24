# frozen_string_literal: true

class Api::Tours::StayDepartures::MetaSerializer < ApplicationSerializer
  attributes %i[id address setting_date name code concentrate_time depature_time]
end
