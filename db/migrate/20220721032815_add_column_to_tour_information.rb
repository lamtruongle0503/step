class AddColumnToTourInformation < ActiveRecord::Migration[6.1]
  def change
    remove_column :tour_information, :adult_amount
    remove_column :tour_information, :baby_amount
    remove_column :tour_information, :children_amount

    add_column :tour_information, :adult_weekday_amount, :float
    add_column :tour_information, :adult_dayoff_amount, :float
    add_column :tour_information, :children_weekday_amount, :float
    add_column :tour_information, :children_dayoff_amount, :float
    add_column :tour_information, :baby_weekday_amount, :float
    add_column :tour_information, :baby_dayoff_amount, :float
  end
end
