class ChangeColumnHotelTaxService < ActiveRecord::Migration[6.1]
  def change
    rename_column :hotels, :tax_service_id, :tax_service
    change_column :hotels, :tax_service, :integer, default: 0
  end
end
