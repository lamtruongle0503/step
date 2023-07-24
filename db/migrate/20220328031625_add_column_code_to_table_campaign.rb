class AddColumnCodeToTableCampaign < ActiveRecord::Migration[6.1]
  def change
    add_column :campaigns, :code, :string
  end
end
