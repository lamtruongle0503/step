# == Schema Information
#
# Table name: contacts
#
#  id                  :bigint           not null, primary key
#  code                :string
#  contents            :text
#  deleted_at          :datetime
#  email               :string
#  furigana            :string
#  phone_number        :string
#  status              :integer          default("open")
#  todo                :string
#  user                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  contact_category_id :integer
#
class Contact < ApplicationRecord
  acts_as_paranoid

  belongs_to :contact_category, optional: true

  enum status: { open: 1, inprogress: 2, done: 3, pending: 4 }
end
