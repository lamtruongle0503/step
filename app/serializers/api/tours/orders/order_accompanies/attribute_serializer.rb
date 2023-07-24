# frozen_string_literal: true

class Api::Tours::Orders::OrderAccompanies::AttributeSerializer < ApplicationSerializer
  attributes :id, :address1, :address2, :birth_day, :departure_start_location,
             :depature_time, :email, :first_name, :last_name, :first_name_kana,
             :last_name_kana, :full_name, :furigana, :gender, :is_owner, :is_save,
             :phone_number, :pickup_location, :post_code, :selected_seat, :age,
             :is_user

  def age
    now = Time.now.utc.to_date
    now.year - object.birth_day.year - (if now.month > object.birth_day.month ||
                               (now.month == object.birth_day.month && now.day >= object.birth_day.day)
                                          0
                                        else
                                          1
                                        end)
  end
end
