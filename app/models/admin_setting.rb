# == Schema Information
#
# Table name: admin_settings
#
#  id              :bigint           not null, primary key
#  deleted_at      :datetime
#  key             :string
#  password_digest :string
#  value           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class AdminSetting < ApplicationRecord
  has_secure_password
end
