# == Schema Information
#
# Table name: tour_stay_itineraries
#
#  id          :bigint           not null, primary key
#  date_index  :integer
#  description :string
#  index       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  tour_id     :bigint           not null
#
# Indexes
#
#  index_tour_stay_itineraries_on_date_index  (date_index)
#  index_tour_stay_itineraries_on_index       (index)
#  index_tour_stay_itineraries_on_tour_id     (tour_id)
#
# Foreign Keys
#
#  fk_rails_...  (tour_id => tours.id)
#
class Tour::StayItinerary < ApplicationRecord
end
