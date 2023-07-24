class ChangeColumnTableAssets < ActiveRecord::Migration[6.1]
  def change
    change_column :assets, :type, 'integer USING (type::integer)'
  end
end
