# == Schema Information
#
# Table name: departments_permissions
#
#  id                    :bigint           not null, primary key
#  deleted_at            :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  company_department_id :bigint
#  permission_id         :bigint
#
# Indexes
#
#  index_departments_permissions_on_company_department_id  (company_department_id)
#  index_departments_permissions_on_permission_id          (permission_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_department_id => company_departments.id)
#  fk_rails_...  (permission_id => permissions.id)
#
class DepartmentsPermission < ApplicationRecord
  acts_as_paranoid

  belongs_to :company_department
  belongs_to :permission
end
