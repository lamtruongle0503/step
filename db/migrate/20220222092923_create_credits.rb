class CreateCredits < ActiveRecord::Migration[6.1]
  def change
    create_table :credits do |t|
      t.belongs_to :user, foreign_key: true
      t.string :customer_id

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
