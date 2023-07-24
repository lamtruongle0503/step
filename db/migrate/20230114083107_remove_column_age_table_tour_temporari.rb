class RemoveColumnAgeTableTourTemporari < ActiveRecord::Migration[6.1]
  def change
    remove_column :tour_temporaries, :age
    add_column :tour_temporaries, :birthday, :date
  end
end
