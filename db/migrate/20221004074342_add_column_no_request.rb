class AddColumnNoRequest < ActiveRecord::Migration[6.1]
  def change
    add_column :hotel_requests, :request_no, :string
  end
end
