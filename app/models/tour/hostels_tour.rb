# == Schema Information
#
# Table name: tour_hostels_tours
#
#  id             :bigint           not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  tour_hostel_id :bigint
#  tour_id        :bigint
#
# Indexes
#
#  index_tour_hostels_tours_on_tour_hostel_id  (tour_hostel_id)
#  index_tour_hostels_tours_on_tour_id         (tour_id)
#
# Foreign Keys
#
#  fk_rails_...  (tour_hostel_id => tour_hostels.id)
#  fk_rails_...  (tour_id => tours.id)
#
class Tour::HostelsTour < ApplicationRecord
  belongs_to :tour_hostel, class_name: 'Tour::Hostel', foreign_key: 'tour_hostel_id'
  belongs_to :tour
end
