# == Schema Information
#
# Table name: contact_categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ContactCategory < ApplicationRecord
  acts_as_paranoid

  has_many :contacts, dependent: :destroy
end
