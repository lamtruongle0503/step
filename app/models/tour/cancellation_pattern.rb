# == Schema Information
#
# Table name: tour_cancellation_patterns
#
#  id                                                                :bigint           not null, primary key
#  codition([{ "flag1": number, "flag2": number, "value": number }]) :jsonb
#  name                                                              :string
#  created_at                                                        :datetime         not null
#  updated_at                                                        :datetime         not null
#
class Tour::CancellationPattern < ApplicationRecord
end
