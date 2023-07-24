# frozen_string_literal: true

class Api::Users::Histories::ShowSerializer < Api::Users::Histories::AttributesSerializer
  attributes :age

  def age
    return if object.birth_day.blank?

    today = Time.current.to_date
    today.year - object.birth_day.year - (if today.month > object.birth_day.month ||
     (today.month == object.birth_day.month && today.day >= object.birth_day.day)
                                            0
                                          else
                                            1
                                          end)
  end
end
