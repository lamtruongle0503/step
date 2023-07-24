class ChangeColumnHotelOptions < ActiveRecord::Migration[6.1]
  def change
    remove_column :hotel_options, :unit
    add_column :hotel_options, :unit, :integer, default: 1
  end
end
