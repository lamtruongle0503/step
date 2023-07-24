class CreateOrderInfos < ActiveRecord::Migration[6.1]
  def change
    create_table :order_infos do |t|
      t.string :buyer_name
      t.belongs_to :order, foreign_key: true, index: true
      t.string :postal_code
      t.string :prefecture
      t.string :address
      t.date :delivery_date
      t.time :delivery_time

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
