class CreateHotelCancellationDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :hotel_cancellation_details do |t|
      t.belongs_to :hotel_cancellation_policy, foreign_key: true, index: { name: "hotel_cancellation_policy_index" }
      t.integer :from
      t.integer :to
      t.float :value
      t.integer :unit, default: 0

      t.timestamps
    end
  end
end
