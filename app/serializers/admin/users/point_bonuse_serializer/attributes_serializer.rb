# frozen_string_literal: true

class Admin::Users::PointBonuseSerializer::AttributesSerializer < ApplicationSerializer
  attributes %i[id user_id full_name birth_day start_date end_date exp_start_date exp_end_date received_point
                created_at code]

  def full_name
    object.user.full_name
  end

  def birth_day
    object.user.birth_day
  end

  def code
    object.user.code
  end
end
