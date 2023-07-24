# == Schema Information
#
# Table name: tour_companies
#
#  id          :bigint           not null, primary key
#  address1    :string
#  address2    :string
#  email       :string
#  name        :string
#  note        :string
#  postal_code :string
#  telephone   :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Tour::Company < ApplicationRecord
  ransacker :address1_or_address2 do
    Arel.sql "CONCAT(address1,'　',address2)"
  end
end
