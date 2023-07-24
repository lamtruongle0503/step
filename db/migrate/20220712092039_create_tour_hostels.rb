class CreateTourHostels < ActiveRecord::Migration[6.1]
  def change
    create_table :tour_hostels do |t|
      t.references :tour, null: false, foreign_key: true
      t.string :name
      t.string :telephone
      t.string :option_ids, array: true, default: []
      t.string :others

      t.timestamps
    end
  end
end
