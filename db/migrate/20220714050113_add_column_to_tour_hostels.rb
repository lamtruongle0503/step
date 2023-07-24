class AddColumnToTourHostels < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :tour_hostels, :tours
    remove_column :tour_hostels, :tour_id
    remove_column :tour_hostels, :option_ids
    remove_column :tour_hostels, :others
    add_column :tour_hostels, :email, :string
    add_column :tour_hostels, :postal_code, :string
    add_column :tour_hostels, :address1, :string
    add_column :tour_hostels, :address2, :string
    add_column :tour_hostels, :description, :string
    add_column :tour_hostels, :note, :string
  end
end
