# == Schema Information
#
# Table name: agencies
#
#  id              :bigint           not null, primary key
#  address         :string
#  code            :string
#  company_name    :string
#  contact_address :string
#  deleted_at      :datetime
#  email           :string
#  fee_shipping    :bigint
#  is_free         :boolean          default(FALSE)
#  name            :string
#  person          :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Agency < ApplicationRecord
  acts_as_paranoid

  has_many :products, dependent: :destroy
  has_many :agency_deliveries, dependent: :destroy
  has_many :deliveries, through: :agency_deliveries
  has_many :agency_payments, dependent: :destroy
  has_many :payments, through: :agency_payments
end
