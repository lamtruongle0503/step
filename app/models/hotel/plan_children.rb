# == Schema Information
#
# Table name: hotel_plan_children
#
#  id                     :bigint           not null, primary key
#  deleted_at             :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  hotel_children_info_id :bigint
#  hotel_plan_id          :bigint
#
# Indexes
#
#  index_hotel_plan_children_on_hotel_children_info_id  (hotel_children_info_id)
#  index_hotel_plan_children_on_hotel_plan_id           (hotel_plan_id)
#
# Foreign Keys
#
#  fk_rails_...  (hotel_children_info_id => hotel_children_infos.id)
#  fk_rails_...  (hotel_plan_id => hotel_plans.id)
#
class Hotel::PlanChildren < ApplicationRecord
  acts_as_paranoid

  belongs_to :hotel_plan, foreign_key: :hotel_plan_id, class_name: 'Hotel::Plan'
  belongs_to :hotel_children_info, foreign_key: :hotel_children_info_id, class_name: 'Hotel::ChildrenInfo'
end
