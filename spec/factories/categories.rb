# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  code       :string
#  deleted_at :datetime
#  name       :string
#  ranking    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :category do
    name { Faker::Tea.type }
    ranking { rand(50..100) }
  end
end
