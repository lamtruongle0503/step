# frozen_string_literal: true

require 'csv'

class Admin::TourOperations::ManagementOperations::DownloadOperations::Create < ApplicationOperation
  def call
    generate_csv
  end

  private

  def tour_managements
    @q = Tour.includes(
      :tour_category, { company_staff: :company_branch }, :tour_company, :tour_bus_infos, :tour_orders
    ).ransack(params[:q])
    @q.result(distinct: true).newest
  end

  def generate_csv
    CSV.generate do |csv|
      csv << I18n.t(:tour_managements, scope: [:headers])
      tour_managements.each_with_index do |record, index|
        csv << [index + 1, record.code, record.name, record.tour_company&.name,
                record.tour_category&.name, record.company_staff&.company_branch&.name,
                number_bus(record), record.company_staff&.name, format_number_people(record),
                tour_status(record.status)]
      end
    end
  end
end
