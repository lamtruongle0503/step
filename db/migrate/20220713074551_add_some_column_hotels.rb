class AddSomeColumnHotels < ActiveRecord::Migration[6.1]
  def change
    add_column :hotels, :payment_options, :jsonb
    add_column :hotels, :check_in, :string
    add_column :hotels, :check_out, :string
    add_column :hotels, :accommodation_tax_rate, :integer
  end
end
