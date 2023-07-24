class FixBanner < ActiveRecord::Migration[6.1]
  def change
    add_column :banners, :is_show, :boolean, default: true
  end
end
