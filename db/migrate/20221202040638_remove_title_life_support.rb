class RemoveTitleLifeSupport < ActiveRecord::Migration[6.1]
  def change
    remove_column :life_supports, :title, :string
  end
end
