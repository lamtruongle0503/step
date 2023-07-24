# == Schema Information
#
# Table name: tour_hostel_departures
#
#  id             :bigint           not null, primary key
#  note           :string
#  option_ids     :string           default([]), is an Array
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  tour_hostel_id :bigint
#  tour_id        :bigint
#
# Indexes
#
#  index_tour_hostel_departures_on_tour_hostel_id  (tour_hostel_id)
#  index_tour_hostel_departures_on_tour_id         (tour_id)
#
# Foreign Keys
#
#  fk_rails_...  (tour_hostel_id => tour_hostels.id)
#  fk_rails_...  (tour_id => tours.id)
#
class Tour::HostelDeparture < ApplicationRecord
  belongs_to :tour, foreign_key: 'tour_id', class_name: 'Tour'
  belongs_to :tour_hostel, foreign_key: 'tour_hostel_id', class_name: 'Tour::Hostel'
end
