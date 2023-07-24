class CreateTourInformation < ActiveRecord::Migration[6.1]
  def change
    create_table :tour_information do |t|
      t.references :tour, null: false, foreign_key: true
      t.float :adult_weekday_price
      t.float :adult_dayoff_price
      t.integer :adult_weekday_discount
      t.integer :adult_dayoff_discount
      t.float :children_weekday_price
      t.float :children_dayoff_price
      t.integer :children_weekday_discount
      t.integer :children_dayoff_discount
      t.float :baby_weekday_price
      t.float :baby_dayoff_price
      t.integer :baby_weekday_discount
      t.integer :baby_dayoff_discount
      t.float :adult_amount
      t.float :children_amount
      t.float :baby_amount
      t.float :max_price
      t.float :min_price

      t.timestamps
    end
  end
end
