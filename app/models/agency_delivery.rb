# == Schema Information
#
# Table name: agency_deliveries
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  agency_id   :bigint
#  delivery_id :bigint
#
# Indexes
#
#  index_agency_deliveries_on_agency_id    (agency_id)
#  index_agency_deliveries_on_delivery_id  (delivery_id)
#
# Foreign Keys
#
#  fk_rails_...  (agency_id => agencies.id)
#  fk_rails_...  (delivery_id => deliveries.id)
#
class AgencyDelivery < ApplicationRecord
  belongs_to :agency
  belongs_to :delivery
end
