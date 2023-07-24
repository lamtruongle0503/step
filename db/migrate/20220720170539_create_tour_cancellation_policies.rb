class CreateTourCancellationPolicies < ActiveRecord::Migration[6.1]
  def change
    create_table :tour_cancellation_policies do |t|
      t.string :name

      t.timestamps
    end
  end
end
