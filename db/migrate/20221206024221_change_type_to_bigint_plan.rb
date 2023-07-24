class ChangeTypeToBigintPlan < ActiveRecord::Migration[6.1]
  def change
    change_column :hotel_plans, :credit_card_transaction_fee, :bigint
  end
end
