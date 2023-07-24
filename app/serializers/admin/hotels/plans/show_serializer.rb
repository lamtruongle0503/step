# frozen_string_literal: true

class Admin::Hotels::Plans::ShowSerializer < Admin::Hotels::Plans::AttributesSerializer
  attributes :created_at,
             :updated_at,
             :setting_payments,
             :payments,
             :room_limit,
             :from_night,
             :to_night,
             :to_room,
             :from_room,
             :is_sale_off,
             :check_in,
             :check_out,
             :is_use_coupon,
             :point_receive,
             :point_bonus,
             :exp_point_receive,
             :point_bonus,
             :exp_point_bonus,
             :option_ids,
             :option_name,
             :settlement_date,
             :settlement_time,
             :credit_card_transaction_fee

  belongs_to :hotel_meal, serializer: Admin::Hotels::Meals::ShowSerializer
  belongs_to :hotel_cancellation_policy,
             serializer: Admin::Hotels::CancellationPolicies::Meta::IndexSerializer
  has_many :children_infos, serializer: Admin::Hotels::Childrens::Meta::IndexSerializer
  has_many :assets, serializer: Assets::AttributesSerializer
  has_one :hotel_plan_option, serializer: Admin::Hotels::PlanOptions::IndexSerializer

  def option_name
    Hotel::Option.where(id: object.option_ids).map(&:name).uniq.join(',')
  end
end
