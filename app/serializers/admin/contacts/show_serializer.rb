# frozen_string_literal: true

class Admin::Contacts::ShowSerializer < Contacts::AttributesSerializer
  attributes :status, :created_at

  belongs_to :contact_category, serializer: ContactCategories::AttributesSerializer
end
