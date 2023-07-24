# == Schema Information
#
# Table name: fortunes
#
#  id           :bigint           not null, primary key
#  color        :string
#  date         :date
#  fortune_type :string
#  image        :string
#  item         :string
#  param        :string
#  rank         :integer
#  sign         :string
#  text         :text
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Fortune < ApplicationRecord
  GENERAL_ID = '0143'.freeze
  LOVE_ID    = '0144'.freeze
  MONEY_ID   = '0145'.freeze
  CAREER_ID  = '0146'.freeze
  HEALTH_ID  = '0176'.freeze

  ARIES       = 'aries'.freeze
  TAURUS      = 'taurus'.freeze
  GEMINI      = 'gemini'.freeze
  CANCER      = 'cancer'.freeze
  LEO         = 'leo'.freeze
  VIRGO       = 'virgo'.freeze
  LIBRA       = 'libra'.freeze
  SCORPIO     = 'scorpio'.freeze
  SAGITTARIUS = 'sagittarius'.freeze
  CAPRICORN   = 'capricorn'.freeze
  AQUARIUS    = 'aquarius'.freeze
  PISCES      = 'pisces'.freeze

  enum fortune_type: {
    general: GENERAL_ID,
    love:    LOVE_ID,
    money:   MONEY_ID,
    career:  CAREER_ID,
    health:  HEALTH_ID,
  }

  enum zodiac: {
    aries:       1,
    taurus:      2,
    gemini:      3,
    cancer:      4,
    leo:         5,
    virgo:       6,
    libra:       7,
    scorpio:     8,
    sagittarius: 9,
    capricorn:   10,
    aquarius:    11,
    pisces:      12,
  }

  scope :by_date, ->(date) { where(date: date).group_by(&:sign) }
end
