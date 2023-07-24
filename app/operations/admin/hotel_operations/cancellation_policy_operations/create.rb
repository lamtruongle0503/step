# frozen_string_literal: true

class Admin::HotelOperations::CancellationPolicyOperations::Create < ApplicationOperation
  def initialize(actor, params)
    super
    @hotel = Hotel.find(params[:id])
  end

  def call
    authorize nil, Hotel::CancellationPolicyPolicy

    HotelContracts::CancellationPolicyContracts::Create.new(cancellation_params).valid!
    ActiveRecord::Base.transaction do
      @hotel_cancellation = @hotel.hotel_cancellation_policies.create!(cancellation_params)
      create_hotel_cancellation_details(@hotel_cancellation.reload)
    end
  end

  private

  def create_hotel_cancellation_details(hotel_cancellation)
    cancellation_details = []
    cancellation_details_params[:cancellation_details].each do |cancellation_detail_params|
      HotelContracts::CancellationDetailContracts::Create
        .new(cancellation_detail_params.merge(
               date_free_cancellation: hotel_cancellation.date_free_cancellation,
             )).valid!
      cancellation_details.push({
                                  hotel_cancellation_policy_id: hotel_cancellation.id,
                                  name:                         cancellation_detail_params[:name],
                                  flg1:                         cancellation_detail_params[:flg1],
                                  flg2:                         cancellation_detail_params[:flg2],
                                  value:                        cancellation_detail_params[:value],
                                  unit:                         cancellation_detail_params[:unit],
                                })
    end
    ActiveRecord::Base.transaction do
      Hotel::CancellationDetail.import!(cancellation_details)
    end
  end

  def cancellation_params
    params.permit(:cxl_management_name, :date_free_cancellation, :is_use)
  end

  def cancellation_details_params
    unless params[:cancellation_details]
      raise BadRequestError,
            cancellation_details: I18n.t('models.can_not_blank')
    end

    params.permit(cancellation_details: %i[name flg1 flg2 value unit])
  end
end
