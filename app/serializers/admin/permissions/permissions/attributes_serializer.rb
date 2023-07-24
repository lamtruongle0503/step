# frozen_string_literal: true

class Admin::Permissions::Permissions::AttributesSerializer < ApplicationSerializer
  attributes :id, :module_name, :action
end
