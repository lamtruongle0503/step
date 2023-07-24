# frozen_string_literal: true

class Admin::Users::IndexSerializer < Admin::Users::AttributesSerializer
  attributes %i[created_at row_number]
end
