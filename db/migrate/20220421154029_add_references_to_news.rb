class AddReferencesToNews < ActiveRecord::Migration[6.1]
  def change
    add_reference :news, :news_category, foreign_key: true, index: true
  end
end
