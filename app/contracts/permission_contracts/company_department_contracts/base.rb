# frozen_string_literal: true

class PermissionContracts::CompanyDepartmentContracts::Base < ApplicationContract
  attribute :name, String

  validates :name, presence: true
end
