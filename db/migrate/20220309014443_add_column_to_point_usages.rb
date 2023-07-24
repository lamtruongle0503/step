class AddColumnToPointUsages < ActiveRecord::Migration[6.1]
  def change
    add_reference :point_usages, :user, foreign_key: true, index: true
  end
end
