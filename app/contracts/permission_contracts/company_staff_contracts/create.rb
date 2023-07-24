# frozen_string_literal: true

class PermissionContracts::CompanyStaffContracts::Create < PermissionContracts::CompanyStaffContracts::Base
  validates :email, presence: true, format: { with: EMAIL_REGEX }, uniqueness: { model: CompanyStaff }
end
