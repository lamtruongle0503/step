# == Schema Information
#
# Table name: agency_payments
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  agency_id  :bigint
#  payment_id :bigint
#
# Indexes
#
#  index_agency_payments_on_agency_id   (agency_id)
#  index_agency_payments_on_payment_id  (payment_id)
#
# Foreign Keys
#
#  fk_rails_...  (agency_id => agencies.id)
#  fk_rails_...  (payment_id => payments.id)
#
class AgencyPayment < ApplicationRecord
  belongs_to :agency
  belongs_to :payment
end
