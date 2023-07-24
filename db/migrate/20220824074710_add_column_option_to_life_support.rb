class AddColumnOptionToLifeSupport < ActiveRecord::Migration[6.1]
  def change
    add_column :life_supports, :option, :integer, default: 1
  end
end
