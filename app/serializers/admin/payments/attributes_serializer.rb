# frozen_string_literal: true

class Admin::Payments::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :code
end
