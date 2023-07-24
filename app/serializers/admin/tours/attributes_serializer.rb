# frozen_string_literal: true

class Admin::Tours::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :code, :status, :start_date, :end_date, :company_name, :category_name, :branch_name,
             :created_at, :updated_at

  def company_name
    object.tour_company&.name
  end

  def category_name
    object.tour_category&.name
  end

  def branch_name
    object.company_staff&.company_branch&.name
  end

  def created_at
    object.created_at.to_date
  end

  def updated_at
    object.updated_at.to_date
  end
end
