# == Schema Information
#
# Table name: holidays
#
#  id           :bigint           not null, primary key
#  date         :date
#  deleted_at   :datetime
#  holiday_name :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Holiday < ApplicationRecord
  acts_as_paranoid

  scope :sort_by_date, lambda { |sort_date_asc|
    if sort_date_asc
      order('date')
    else
      order('date DESC')
    end
  }
end
