# frozen_string_literal: true

class Admin::Tours::Orders::BusInfos::Accompanies::AttributesSerializer < ApplicationSerializer
  attributes :id, :full_name, :furigana, :room, :selected_seat, :name_option, :memo, :is_owner,
             :is_user, :first_name, :last_name, :first_name_kana, :last_name_kana

  def memo
    object.tour_order.memo
  end
end
