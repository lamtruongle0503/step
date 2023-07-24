class AddColumnDateToFortune < ActiveRecord::Migration[6.1]
  def change
    add_column :fortunes, :date, :date
  end
end
