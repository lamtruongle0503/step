class CreateTourCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :tour_companies do |t|
      t.string :name
      t.string :telephone
      t.string :email
      t.string :postal_code
      t.string :address1
      t.string :address2
      t.string :note

      t.timestamps
    end
  end
end
