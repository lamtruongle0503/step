# frozen_string_literal: true

class NotificationContracts::Base < ApplicationContract
  attribute :title, String
  attribute :description, String
  attribute :prefecture_ids, Array
  attribute :gender, Integer
  attribute :is_gender, Boolean
  attribute :is_prefecture, Boolean
  attribute :month_birthday, Array

  validates :title, presence: true
  validates :description, presence: true
  validates :is_gender, inclusion: { in: [true, false] }
  validates :is_prefecture, inclusion: { in: [true, false] }
  validates :prefecture_ids, presence: true, existence: Prefecture.name, unless: -> { is_prefecture }
  validates :gender, presence: true, inclusion: { in: User.genders }, unless: -> { is_gender }
  validates :month_birthday, inclusion: { in: 1..12 }
end
