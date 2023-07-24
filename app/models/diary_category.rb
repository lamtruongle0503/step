# == Schema Information
#
# Table name: diary_categories
#
#  id               :bigint           not null, primary key
#  background_color :string
#  index            :integer
#  name             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class DiaryCategory < ApplicationRecord
end
