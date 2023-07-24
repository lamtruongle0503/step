# frozen_string_literal: true

class Admin::TourOperations::BusInfoOperations::DownloadCsvOperations::Create < ApplicationOperation
  def call
    bus = Tour::BusInfo.includes(tour_orders: %i[tour_order_accompanies user]).find(params[:bus_info_id])
    generate_csv(bus)
  end

  private

  def generate_csv(bus) # rubocop:disable Metrics/MethodLength
    tour_orders = bus.tour_orders.newest
    CSV.generate do |csv|
      csv << I18n.t(:tour_bus_info, scope: [:headers])
      tour_orders.each_with_index do |tour_order, index|
        tour_order.tour_order_accompanies.each do |tour_order_accompanies|
          csv << if tour_order_accompanies.is_owner
                   [
                     index + 1,
                     tour_order.order_no,
                     tour_order.user.code,
                     tour_order_accompanies.full_name,
                     tour_order_accompanies.furigana,
                     tour_order_accompanies.selected_seat,
                     tour_order_accompanies.name_option.to_h[:name],
                     tour_order.memo,
                   ]
                 else
                   [
                     nil,
                     nil,
                     nil,
                     tour_order_accompanies.full_name,
                     tour_order_accompanies.furigana,
                     tour_order_accompanies.selected_seat,
                     tour_order_accompanies.name_option.to_h[:name],
                     nil,
                   ]
                 end
        end
      end
    end
  end
end
