# == Schema Information
#
# Table name: admins
#
#  id              :bigint           not null, primary key
#  name            :string
#  email           :string
#  password_digest :string
#  phone_number    :string
#  deleted_at      :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Admin < ApplicationRecord
  has_secure_password
end
