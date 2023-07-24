# == Schema Information
#
# Table name: company_departments
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CompanyDepartment < ApplicationRecord
  acts_as_paranoid

  has_many :company_staffs
  has_many :departments_permissions
  has_many :permissions, through: :departments_permissions
end
