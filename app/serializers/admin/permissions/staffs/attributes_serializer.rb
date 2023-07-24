# frozen_string_literal: true

class Admin::Permissions::Staffs::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :email, :staff_password

  belongs_to :company_branch, serializer: Admin::Permissions::Branches::AttributesSerializer
  belongs_to :company_department, serializer: Admin::Permissions::Departments::AttributesSerializer
end
