# frozen_string_literal: true

class PermissionContracts::CompanyStaffContracts::Base < ApplicationContract
  attribute :name,                  String
  attribute :email,                 String
  attribute :password,              String
  attribute :company_branch_id,     Integer
  attribute :company_department_id, Integer
  attribute :staff_password,        String

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :name, presence: true
  validates :password, presence: true,
                       length:   {
                         minimum: 6,
                         maximum: 16,
                       }
  validates :staff_password, presence: true,
                             length:   {
                               minimum: 6,
                               maximum: 16,
                             }
  validates :company_branch_id, presence: true, existence: CompanyBranch.name
  validates :company_department_id, presence: true, existence: CompanyDepartment.name
end
