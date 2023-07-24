# frozen_string_literal: true

class Admin::Users::Addresses::AttributesSerializer < ApplicationSerializer
  attributes :id, :full_name, :postcode, :address1, :address2, :telephone, :is_default
end
