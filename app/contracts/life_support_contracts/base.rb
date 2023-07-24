# frozen_string_literal: true

class LifeSupportContracts::Base < ApplicationContract
  attribute :content,        String
  attribute :telephone,      String
  attribute :start_date,     Date
  attribute :end_date,       Date
  attribute :prefecture_ids, Array
  attribute :option,         Integer
  attribute :company_name,   String
  attribute :email,          String

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :content, :start_date, :end_date, :company_name, presence: true
  validates :prefecture_ids, presence: true, existences: Prefecture.name
  validates :option, inclusion: { in: LifeSupport.options }
  validates :email, presence: true, format: { with: EMAIL_REGEX }
end
