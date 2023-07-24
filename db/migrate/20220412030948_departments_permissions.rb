class DepartmentsPermissions < ActiveRecord::Migration[6.1]
  def change
    create_table :departments_permissions do |t|
      t.belongs_to :company_department, foreign_key: true, index: true
      t.belongs_to :permission, foreign_key: true, index: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
