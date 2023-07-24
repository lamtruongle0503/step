class CreateHolidays < ActiveRecord::Migration[6.1]
  def change
    create_table :holidays do |t|
      t.string :holiday_name
      t.date :date

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
