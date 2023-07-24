class DropTourCancellationPatternsTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :tour_cancellation_patterns
  end
end
