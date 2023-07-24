# frozen_string_literal: true

class Admin::Banners::Requests::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :postal_code, :address1, :address2, :phone_number, :status, :banner

  def banner
    Admin::Banners::AttributesSerializer.new(object.banner).as_json
  end
end
