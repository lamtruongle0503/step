# == Schema Information
#
# Table name: tour_hostels
#
#  id          :bigint           not null, primary key
#  address1    :string
#  address2    :string
#  description :string
#  email       :string
#  name        :string
#  note        :string
#  postal_code :string
#  telephone   :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Tour::Hostel < ApplicationRecord
  has_many :hostels_tours, class_name: 'Tour::HostelsTour', foreign_key: 'tour_hostel_id', dependent: :destroy
  has_many :hostel_departures, class_name: 'Tour::HostelDeparture', foreign_key: 'tour_hostel_id',
dependent: :destroy

  ransacker :address do
    Arel.sql "CONCAT(address1,'　',address2)"
  end
end
