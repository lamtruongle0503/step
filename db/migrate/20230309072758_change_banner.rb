class ChangeBanner < ActiveRecord::Migration[6.1]
  def change
    remove_column :banners, :is_show
    remove_column :banners, :name

    add_column :banners, :option, :integer, default: 1
    add_column :banners, :start_date, :date
    add_column :banners, :end_date, :date
    add_column :banners, :content, :text
    add_column :banners, :telephone, :string
    add_column :banners, :company_name, :string
    add_column :banners, :email, :string
  end
end
