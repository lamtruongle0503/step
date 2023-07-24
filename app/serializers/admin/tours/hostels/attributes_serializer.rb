# frozen_string_literal: true

class Admin::Tours::Hostels::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :address1, :address2, :email, :note, :postal_code, :telephone, :description,
             :created_at

  def created_at
    return unless object.created_at

    object.created_at.to_date
  end
end
