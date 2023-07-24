# frozen_string_literal: true

class Admin::TourOperations::ManagementOperations::ImportOperations::Create < ApplicationOperation
  attr_reader :tour

  def initialize(actor, params)
    super
    @tour = Tour.find(params[:management_id])
  end

  def call
    arr_import = []
    CSV.foreach(params[:management_file], headers: true) do |row|
      arr_import << { bus_no:             row.to_h['号車'],
                      departure_location: row.to_h['出発地'],
                      number_of_people:   row.to_h['人数'],
                      capacity:           row.to_h['定員パターン'],
                      tour_id:            tour.id }
    end

    ActiveRecord::Base.transaction do
      Tour::ManagementFile.where(tour_id: tour.id).destroy_all
      Tour::ManagementFile.import! arr_import
    end
  end
end
