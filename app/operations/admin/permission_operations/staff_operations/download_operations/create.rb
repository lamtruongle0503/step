# frozen_string_literal: true

require 'csv'

class Admin::PermissionOperations::StaffOperations::DownloadOperations::Create < ApplicationOperation
  def call
    generate_csv
  end

  private

  def staffs
    @q = CompanyStaff.includes(:company_department, :company_branch).ransack(params[:q])
    @q.result(distinct: true).newest
  end

  def generate_csv
    CSV.generate do |csv|
      csv << I18n.t(:staffs, scope: [:headers])
      staffs.each_with_index do |record, index|
        csv << [index + 1, record.name, record.email, record.password,
                record.company_branch&.name, record.company_department&.name]
      end
    end
  end
end
