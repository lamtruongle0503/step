# == Schema Information
#
# Table name: payments
#
#  id         :bigint           not null, primary key
#  code       :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Payment < ApplicationRecord
  has_many :agencies
  has_many :tour_payments, class_name: 'TourPayment', foreign_key: 'payment_id'
end
