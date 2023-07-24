# == Schema Information
#
# Table name: company_staffs
#
#  id                    :bigint           not null, primary key
#  deleted_at            :datetime
#  email                 :string
#  name                  :string
#  password_digest       :string
#  staff_password        :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  company_branch_id     :bigint
#  company_department_id :bigint
#
# Indexes
#
#  index_company_staffs_on_company_branch_id      (company_branch_id)
#  index_company_staffs_on_company_department_id  (company_department_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_branch_id => company_branches.id)
#  fk_rails_...  (company_department_id => company_departments.id)
#
class CompanyStaff < ApplicationRecord
  acts_as_paranoid
  has_secure_password

  belongs_to :company_branch
  belongs_to :company_department
  has_many :permissions, through: :company_department
end
