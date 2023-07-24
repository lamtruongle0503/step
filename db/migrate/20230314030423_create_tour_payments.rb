class CreateTourPayments < ActiveRecord::Migration[6.1]
  def change
    create_table :tour_payments do |t|
      t.belongs_to :tour, foreign_key: true
      t.belongs_to :payment, foreign_key: true

      t.timestamps
    end
  end
end
