# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::Coupons', type: :request do
  include_context 'user with authentication grant'

  describe 'GET /api/v1/tours' do
    let(:prefecture1) { create :prefecture }
    let(:prefecture2) { create :prefecture }
    let(:prefecture3) { create :prefecture }
    let(:tour1) { create :tour }
    let(:tour2) { create :tour }
    let(:tour3) { create :tour }
    let!(:tours_prefecture1) { create :tours_prefecture, tour: tour1, prefecture: prefecture1 }
    let!(:tours_prefecture2) { create :tours_prefecture, tour: tour2, prefecture: prefecture2 }
    let!(:tours_prefecture3) { create :tours_prefecture, tour: tour3, prefecture: prefecture1 }

    context 'with valid params' do
      before { get api_v1_tours_path, headers: headers, params: params }

      # context 'with tours' do
      #   let(:params) do
      #     { prefecture_id: prefecture1.id }
      #   end
      #   it 'response correct array with 200 status' do
      #     expect_http_status 200
      #     expect(response_body.pluck('id')).to match_array [tour1.id, tour3.id]
      #   end
      # end

      context 'with empty tours' do
        let(:params) do
          { prefecture_id: prefecture3.id }
        end

        it 'response correct array with 200 status' do
          expect_http_status 200
          expect(response_body.pluck('id')).to match_array []
        end
      end
    end

    context 'with invalid params' do
      let(:params) do
        { prefecture_id: :invalid }
      end
      it 'response record not found with 404 status' do
        get api_v1_tours_path, headers: headers, params: params
        expect_http_status 404
      end
    end
  end

  describe 'GET /api/v1/tours/:id' do
    context 'with correct tour id' do
      context 'with coupon available' do
        # let(:coupon1) { create :coupon, start_time: DateTime.current, end_time: DateTime.current + 2.day }
        # let(:coupon2) { create :coupon, start_time: DateTime.current, end_time: DateTime.current + 3.day }
        # let(:coupon3) { create :coupon, start_time: DateTime.current + 3.day, end_time: DateTime.current + 4.day }
        # let(:tour) { create :tour }
        # let!(:tours_coupon1) { create :coupons_module, module: tour, coupon: coupon1 }
        # let!(:tours_coupon2) { create :coupons_module, module: tour, coupon: coupon2 }
        # let!(:tours_coupon3) { create :coupons_module, module: tour, coupon: coupon3 }
        # before { get api_v1_tour_path(tour), headers: headers }

        # it 'response correct array with 200 status' do
        #   expect_http_status 200
        #   expect(response_body['coupons'].pluck('id')).to match_array [coupon1.id, coupon2.id]
        # end
      end

      context 'with coupon unavailable' do
        let(:coupon1) { create :coupon, start_time: DateTime.current - 3.day, end_time: DateTime.current - 2.day }
        let(:coupon2) { create :coupon, start_time: DateTime.current - 2.day, end_time: DateTime.current - 1.day }
        let(:coupon3) { create :coupon, start_time: DateTime.current + 3.day, end_time: DateTime.current + 4.day }
        let(:tour) { create :tour }
        let!(:tours_coupon1) { create :coupons_module, module: tour, coupon: coupon1 }
        let!(:tours_coupon2) { create :coupons_module, module: tour, coupon: coupon2 }
        let!(:tours_coupon3) { create :coupons_module, module: tour, coupon: coupon3 }
        before { get api_v1_tour_path(tour), headers: headers }

        it 'response correct array with 200 status' do
          expect_http_status 200
          expect(response_body['id']).to eq tour.id
          expect(response_body['coupons'].pluck('id')).to match_array []
        end
      end
    end

    context 'with wrong tour id' do
      before { get api_v1_tour_path(id: :invalid), headers: headers }

      it 'response record not found with 404 status' do
        expect_http_status :not_found
      end
    end
  end
end
