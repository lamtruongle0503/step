class AddColumnCodeToTours < ActiveRecord::Migration[6.1]
  def change
    add_column :tours, :code, :string
  end
end
