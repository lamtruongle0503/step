# == Schema Information
#
# Table name: point_usages
#
#  id             :bigint           not null, primary key
#  deleted_at     :datetime
#  description    :string
#  end_date       :date
#  exp_end_date   :date
#  exp_start_date :date
#  is_received    :boolean          default(FALSE)
#  module_type    :string           not null
#  received_date  :date
#  received_point :float
#  start_date     :date
#  status         :integer          default("pending")
#  title          :string
#  type_point     :integer          default("normal")
#  used_point     :float
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  module_id      :bigint           not null
#  user_id        :bigint
#
# Indexes
#
#  index_point_usages_on_module   (module_type,module_id)
#  index_point_usages_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class PointUsage < ApplicationRecord
  acts_as_paranoid

  belongs_to :module, polymorphic: true
  belongs_to :user
  belongs_to :order, -> { with_deleted },
             foreign_key: :module_id,
             optional:    true
  belongs_to :tour_order, foreign_key: :module_id, optional: true, class_name: 'Tour::Order'
  belongs_to :hotel_order, -> { with_deleted },
             foreign_key: :module_id,
             optional:    true,
             class_name:  'Hotel::Order'

  scope :used_points, -> { where.not(used_point: nil) }
  scope :valid, -> { where('used_point > 0') }
  scope :point_usage_hotel, lambda {
    where(<<-SQL.strip_heredoc, date: Time.current.to_date, name: Hotel::Order.name)
      module_type = :name
      AND is_received = FALSE
      AND used_point IS NULL
      AND (:date BETWEEN exp_start_date AND exp_end_date)
    SQL
  }

  # Type point
  NORMAL = 'normal'.freeze
  BONUS = 'bonus'.freeze
  WAITING = 'waiting'.freeze
  PENDING = 'pending'.freeze
  ACCEPT = 'accept'.freeze

  TYPE_POINT = [NORMAL, BONUS].freeze
  enum type_point: { normal: 0, bonus: 1, waiting: 2 }
  enum status: { pending: 0, accept: 1 }

  ransacker :send_date, type: :date do
    Arel.sql "DATE(point_usages.created_at + interval '9 hour')"
  end

  ransacker :start_date, type: :date do
    Arel.sql "DATE(point_usages.start_date + interval '9 hour')"
  end

  ransacker :end_date, type: :date do
    Arel.sql "DATE(point_usages.end_date + interval '9 hour')"
  end

  scope :not_pending, -> { where.not(status: PointUsage.statuses[PointUsage::PENDING]) }
  scope :type_bonus, -> { where(type_point: PointUsage::BONUS) }
end
