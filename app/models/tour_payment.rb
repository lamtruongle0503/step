# == Schema Information
#
# Table name: tour_payments
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  payment_id :bigint
#  tour_id    :bigint
#
# Indexes
#
#  index_tour_payments_on_payment_id  (payment_id)
#  index_tour_payments_on_tour_id     (tour_id)
#
# Foreign Keys
#
#  fk_rails_...  (payment_id => payments.id)
#  fk_rails_...  (tour_id => tours.id)
#
class TourPayment < ApplicationRecord
  self.table_name = :tour_payments
  belongs_to :tour
  belongs_to :payment
end
