# frozen_string_literal: true

class PermissionContracts::CompanyStaffContracts::Update < PermissionContracts::CompanyStaffContracts::Base
  attribute :record, CompanyStaff

  validates :email, presence:   true,
                    format:     { with: EMAIL_REGEX },
                    uniqueness: { model: CompanyStaff },
                    if:         -> { valid_email? }

  def valid_email?
    record.email != email
  end
end
