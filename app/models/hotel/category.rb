# == Schema Information
#
# Table name: hotel_categories
#
#  id         :bigint           not null, primary key
#  code       :string
#  deleted_at :datetime
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Hotel::Category < ApplicationRecord
  acts_as_paranoid
end
