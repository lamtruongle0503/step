# == Schema Information
#
# Table name: tour_categories
#
#  id         :bigint           not null, primary key
#  code       :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tour::Category < ApplicationRecord
end
