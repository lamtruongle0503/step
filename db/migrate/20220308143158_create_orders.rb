class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :code, index: true
      t.belongs_to :user, foreign_key: true, index: true
      t.float :purchased_amout
      t.float :delivery_amout
      t.integer :payment_status
      t.integer :payment_type
      t.integer :delivery_status
      t.integer :order_status

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
