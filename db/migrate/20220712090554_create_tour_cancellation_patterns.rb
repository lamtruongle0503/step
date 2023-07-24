class CreateTourCancellationPatterns < ActiveRecord::Migration[6.1]
  def change
    create_table :tour_cancellation_patterns do |t|
      t.string :name
      t.jsonb :codition, comment: '[{ "flag1": number, "flag2": number, "value": number }]'

      t.timestamps
    end
  end
end
