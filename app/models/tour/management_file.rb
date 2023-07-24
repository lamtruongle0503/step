# == Schema Information
#
# Table name: tour_management_files
#
#  id                 :bigint           not null, primary key
#  bus_no             :string
#  capacity           :string
#  departure_location :string
#  number_of_people   :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  tour_id            :integer
#
class Tour::ManagementFile < ApplicationRecord
  self.table_name = 'tour_management_files'

  belongs_to :tour, class_name: 'Tour', foreign_key: 'tour_id'
end
