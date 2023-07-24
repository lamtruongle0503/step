class AddColumnNoticeToCoupons < ActiveRecord::Migration[6.1]
  def change
    add_column :coupons, :is_notice, :boolean
  end
end
