# == Schema Information
#
# Table name: permissions
#
#  id          :bigint           not null, primary key
#  action      :string
#  deleted_at  :datetime
#  description :string
#  module_name :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Permission < ApplicationRecord
  acts_as_paranoid

  has_many :departments_permissions, dependent: :destroy
  has_many :departments, through: :departments_permissions
end
