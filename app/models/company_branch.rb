# == Schema Information
#
# Table name: company_branches
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CompanyBranch < ApplicationRecord
  acts_as_paranoid

  has_many :company_staffs
end
