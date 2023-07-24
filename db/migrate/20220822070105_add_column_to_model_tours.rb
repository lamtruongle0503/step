class AddColumnToModelTours < ActiveRecord::Migration[6.1]
  def change
    add_column :tours, :min_number_participant, :integer
    add_column :tours, :other_fee, :string
  end
end
