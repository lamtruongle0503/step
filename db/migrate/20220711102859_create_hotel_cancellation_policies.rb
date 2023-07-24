class CreateHotelCancellationPolicies < ActiveRecord::Migration[6.1]
  def change
    create_table :hotel_cancellation_policies do |t|
      t.belongs_to :hotel, foreign_key: true
      t.string :cxl_management_name
      t.integer :date_free_cancellation
      t.boolean :is_use, default: false

      t.timestamps
    end
  end
end
