class ChangeTourInformationToTourInformations < ActiveRecord::Migration[6.1]
  def change
    rename_table :tour_information, :tour_informations
  end
end
