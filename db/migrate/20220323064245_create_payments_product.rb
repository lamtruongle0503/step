class CreatePaymentsProduct < ActiveRecord::Migration[6.1]
  def change
    create_table :payments_products do |t|
      t.belongs_to :payment, foreign_key: true
      t.belongs_to :product, foreign_key: true

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
