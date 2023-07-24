class AddColumnReceivedDateToPointUsage < ActiveRecord::Migration[6.1]
  def change
    add_column :point_usages, :received_date, :datetime
  end
end
