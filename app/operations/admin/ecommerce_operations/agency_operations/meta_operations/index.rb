# frozen_string_literal: true

class Admin::EcommerceOperations::AgencyOperations::MetaOperations::Index < ApplicationOperation
  def call
    Agency.all.order(name: :asc)
  end
end
