# == Schema Information
#
# Table name: assets
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  file_type  :string
#  type       :integer
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Asset < ApplicationRecord
  self.inheritance_column = :_type_disabled
  acts_as_paranoid

  IMAGE_DETAILS     = 'details'.freeze
  IMAGE_PREVIEWS    = 'previews'.freeze
  IMAGE_BACKGROUNDS = 'backgrounds'.freeze
  PRODUCT_AVATAR    = 'product_avatar'.freeze
  THUMBNAIL         = 'thumbnail'.freeze
  H_VIDEO_INTRO     = 'h_video_intro'.freeze
  H_IMAGE_INTRO     = 'h_image_intro'.freeze
  H_PDF_INTRO       = 'h_pdf_intro'.freeze
  T_VIDEO_INTRO     = 't_video_intro'.freeze
  T_IMAGE_INTRO     = 't_image_intro'.freeze
  T_PDF_INTRO       = 't_pdf_intro'.freeze

  has_one :assets_module, dependent: :destroy

  enum type: {
    details:        1,
    previews:       2,
    backgrounds:    3,
    thumbnail:      4,
    h_video_intro:  5,
    h_image_intro:  6,
    product_avatar: 7,
    t_video_intro:  8,
    t_image_intro:  9,
    t_pdf_intro:    10,
    h_pdf_intro:    11,
  }
end
