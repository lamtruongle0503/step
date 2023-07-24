# frozen_string_literal: true

require 'csv'

class Admin::TourOperations::DownloadOperations::Create < ApplicationOperation
  def call
    generate_csv
  end

  private

  def tours
    @q = Tour.includes(
      :tour_category, { company_staff: :company_branch }, :tour_company
    ).ransack(params[:q])
    @q.result(distinct: true).newest
  end

  def generate_csv
    CSV.generate do |csv|
      csv << I18n.t(:tours, scope: [:headers])
      tours.each do |record|
        csv << [record.code, record.name, record&.tour_company&.name, record&.tour_category&.name,
                record&.company_staff&.company_branch&.name, record&.company_staff&.name,
                I18n.l(record.created_at, format: :full_date), I18n.l(record.updated_at, format: :full_date),
                tour_status(record.status)]
      end
    end
  end
end
