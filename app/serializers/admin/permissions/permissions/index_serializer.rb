# frozen_string_literal: true

class Admin::Permissions::Permissions::IndexSerializer < ApplicationSerializer
  attributes :permissions, :department_permissions

  def permissions
    object[:permissions]&.map do |permission|
      Admin::Permissions::Permissions::AttributesSerializer.new(permission).as_json
    end
  end

  def department_permissions
    object[:department_permissions]&.map do |permission|
      Admin::Permissions::Permissions::AttributesSerializer.new(permission).as_json
    end
  end
end
