# frozen_string_literal: true

class Admin::Notifications::AttributesSerializer < ApplicationSerializer
  attributes :id, :title, :description, :created_at
end
