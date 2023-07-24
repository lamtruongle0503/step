# frozen_string_literal: true

class Users::AttributesSerializer < ApplicationSerializer
  attributes %i[id first_name last_name first_name_kana last_name_kana gender birth_day post_code address1
                address2 telephone note is_dm module_name email nick_name phone_number point diary_flg]

  def module_name
    object.class.name
  end

  def point
    object.point.to_i + object.point_bonus.to_i
  end
end
