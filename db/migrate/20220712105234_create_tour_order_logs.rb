class CreateTourOrderLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :tour_order_logs do |t|
      t.references :tour_order, null: false, foreign_key: true
      t.string :tour, comment: 'json của các field trong bảng tour'
      t.string :tour_information, comment: 'json của các field trong bảng tour_information'
      t.string :tour_cancellation_patterns, comment: 'Chỉ lưu trong trường hợp order này huỷ, và lưu tại thời điểm thực hiện lệnh huỷ'
      t.string :tour_stay_departures

      t.timestamps
    end
  end
end
