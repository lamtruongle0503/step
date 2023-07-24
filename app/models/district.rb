# == Schema Information
#
# Table name: districts
#
#  id            :bigint           not null, primary key
#  code          :string
#  deleted_at    :datetime
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  prefecture_id :bigint
#
# Indexes
#
#  index_districts_on_prefecture_id  (prefecture_id)
#
# Foreign Keys
#
#  fk_rails_...  (prefecture_id => prefectures.id)
#
class District < ApplicationRecord
  acts_as_paranoid

  belongs_to :prefecture
  has_one :coordinate, as: :module
  has_many :weather_reports, dependent: :destroy
end
