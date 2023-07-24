# frozen_string_literal: true

class Api::Ecommerces::Agencies::ShowSerializer < Api::Ecommerces::Agencies::AttributesSerializer
  attributes :company_name, :person, :address, :contact_address, :email
end
