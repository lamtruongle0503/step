class CreateTourCancellationDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :tour_cancellation_details do |t|
      t.references :tour_cancellation_policy, foreign_key: true, index: true
      t.string :name
      t.integer :flg1
      t.integer :flg2
      t.float :value
      t.integer :unit, default: 1

      t.timestamps
    end
  end
end
