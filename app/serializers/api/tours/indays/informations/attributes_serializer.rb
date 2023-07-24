# frozen_string_literal: true

class Api::Tours::Indays::Informations::AttributesSerializer < ApplicationSerializer
  attributes :id, :adult_dayoff_amount,
             :adult_dayoff_discount,
             :adult_dayoff_price,
             :adult_weekday_amount,
             :adult_weekday_discount,
             :adult_weekday_price,
             :baby_dayoff_amount,
             :baby_dayoff_discount,
             :baby_dayoff_price,
             :baby_weekday_amount,
             :baby_weekday_discount,
             :baby_weekday_price,
             :children_dayoff_amount,
             :children_dayoff_discount,
             :children_dayoff_price,
             :children_weekday_amount,
             :children_weekday_discount,
             :children_weekday_price,
             :max_price,
             :min_price,
             def min_price
               [object.adult_dayoff_amount, object.adult_weekday_amount].min.to_f.round
             end

  def max_price
    [object.adult_dayoff_amount, object.adult_weekday_amount].max.to_f.round
  end
end
