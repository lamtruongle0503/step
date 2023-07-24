# frozen_string_literal: true

require 'tour/cancellation_policy'
require 'tour/cancellation_detail'
class Admin::TourOperations::CancellationDetailOperations::Create < ApplicationOperation
  def call
    authorize nil, Tour::Management::CancellationPolicyPolicy

    ActiveRecord::Base.transaction do
      tour_cancellation_policy = Tour::CancellationPolicy.find(params[:cancellation_policy_id])
      create_cancellation_detail!(tour_cancellation_policy.reload)
    end
  end

  private

  def create_cancellation_detail!(tour_cancellation_policy)
    cancellation_details = []
    cancellation_detail_params[:cancellation_details].each do |cancellation_detail_param|
      TourContracts::CancellationDetailContracts::Create.new(cancellation_detail_param).valid!
      cancellation_details.push({
                                  tour_cancellation_policy_id: tour_cancellation_policy.id,
                                  name:                        cancellation_detail_param[:name],
                                  flg1:                        cancellation_detail_param[:flg1],
                                  flg2:                        cancellation_detail_param[:flg2],
                                  value:                       cancellation_detail_param[:value],
                                  unit:                        cancellation_detail_param[:unit],
                                })
    end
    tour_cancellation_policy.tour_cancellation_details.import!(cancellation_details)
  end

  def cancellation_detail_params
    unless params[:cancellation_details]
      raise BadRequestError,
            cancellation_details: I18n.t('models.can_not_blank')
    end

    params.permit(cancellation_details: %i[name flg1 flg2 value unit])
  end
end
