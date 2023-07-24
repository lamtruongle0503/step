# frozen_string_literal: true

class PermissionContracts::CompanyBranchContracts::Base < ApplicationContract
  attribute :name, String

  validates :name, presence: true
end
