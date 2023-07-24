class AddColumnCodeInAgency < ActiveRecord::Migration[6.1]
  def change
    add_column :agencies, :code, :string
  end
end
