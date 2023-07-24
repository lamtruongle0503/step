class AddColumnBackgroundDiaryCategory < ActiveRecord::Migration[6.1]
  def change
    add_column :diary_categories, :background_color, :string, null: true
  end
end
