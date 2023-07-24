class AddColumnEmailOfHotel < ActiveRecord::Migration[6.1]
  def change
    add_column :hotels, :email, :string
  end
end
