class CreateAgencyPayments < ActiveRecord::Migration[6.1]
  def change
    create_table :agency_payments do |t|
      t.belongs_to :agency, foreign_key: true, index: true
      t.belongs_to :payment, foreign_key: true, index: true

      t.timestamps
    end
  end
end
