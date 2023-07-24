# frozen_string_literal: true

class Admin::Hotels::Plans::Meta::IndexSerializer < ApplicationSerializer
  attributes :id, :name, :management_name
end
