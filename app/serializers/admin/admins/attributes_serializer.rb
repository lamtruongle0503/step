# frozen_string_literal: true

class Admin::Admins::AttributesSerializer < ApplicationSerializer
  attributes %i[id name email module_name]

  def module_name
    object.class.name
  end
end
