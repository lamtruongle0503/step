# frozen_string_literal: true

# require 'rails_helper'

# RSpec.describe 'Admin::Coupons', type: :request do
#   include_context 'admin with authentication grant'

#   describe 'GET /admin/coupons' do
#     context 'with coupons' do
#       let!(:coupons) { create_list :coupon, 10 }

#       it 'response array with 200 status' do
#         get admin_coupons_path, headers: headers
#         expect_http_status 200
#         expect(response_body['data'].pluck('id')).to match_array Coupon.joins(:coupons_modules).where(coupons_modules: { module_type: Tour.name }).pluck(:id)
#       end
#     end

#     context 'with search params ' do
#       let(:tour1) { create :tour, name: 'tour 1' }
#       let(:tour2) { create :tour, name: 'tour 2' }
#       let(:prefecture) { create :prefecture, name: 'prefecture' }
#       let(:coupon1) { create :coupon, start_time: DateTime.current + 1.day, end_time: DateTime.current + 2.day }
#       let(:coupon2) { create :coupon, start_time: DateTime.current + 3.day, end_time: DateTime.current + 4.day }
#       let(:coupon3) { create :coupon, start_time: DateTime.current + 4.day, end_time: DateTime.current + 6.day }
#       let!(:tours_coupon1) { create :coupons_module, module: tour1, coupon: coupon1 }
#       let!(:tours_coupon2) { create :coupons_module, module: tour2, coupon: coupon2 }
#       let!(:tours_coupon3) { create :coupons_module, module: tour1, coupon: coupon3 }
#       let!(:coupons_prefecture1) { create :coupons_prefecture, coupon: coupon1, prefecture: prefecture }
#       let!(:coupons_prefecture2) { create :coupons_prefecture, coupon: coupon3, prefecture: prefecture }
#       let!(:coupon_tour1) { create :coupon_tour, start_time: DateTime.current + 1.day, end_time: DateTime.current + 2.day, tour: tour1 }
#       let!(:coupon_tour2) { create :coupon_tour, start_time: DateTime.current + 3.day, end_time: DateTime.current + 4.day, tour: tour2 }
#       let!(:coupon_tour3) { create :coupon_tour, start_time: DateTime.current + 4.day, end_time: DateTime.current + 6.day, tour: tour1 }
#       let!(:coupon_tour_prefecture1) { create :coupon_tour_prefecture, coupon_tour: coupon_tour1, prefecture: prefecture }
#       let!(:coupon_tour_prefecture2) { create :coupon_tour_prefecture, coupon_tour: coupon_tour3, prefecture: prefecture }

#       before { get admin_coupons_path, headers: headers, params: params }

#       context 'with search params is tour code' do
#         let(:params) do
#           {
#             q: { tour_id_eq: tour1.id },
#           }
#         end
#         it 'response correct array with 200 status' do
#           expect_http_status 200
#           expect(response_body['data'].pluck('id')).to match_array [coupon_tour1.id, coupon_tour3.id]
#         end
#       end

#       context 'with search params is tour name' do
#         let(:params) do
#           {
#             q: { tour_name_cont: 'tour 2' },
#           }
#         end
#         it 'response correct array with 200 status' do
#           expect_http_status 200
#           expect(response_body['data'].pluck('id')).to match_array [coupon_tour2.id]
#         end
#       end

#       context 'with search params is prefecture name' do
#         let(:params) do
#           {
#             q: { prefectures_name_cont: 'pre' },
#           }
#         end
#         it 'response correct array with 200 status' do
#           expect_http_status 200
#           expect(response_body['data'].pluck('id')).to match_array [coupon_tour1.id, coupon_tour3.id]
#         end
#       end

#       context 'with search params is date type' do
#         let(:params) do
#           {
#             q: { start_time_lteq: DateTime.current.beginning_of_day + 2.day, end_time_gteq: DateTime.current.beginning_of_day + 2.day },
#           }
#         end
#         it 'response correct array with 200 status' do
#           expect_http_status 200
#           expect(response_body['data'].pluck('id')).to match_array [coupon_tour1.id]
#         end
#       end

#       context 'with search params only tour name and date' do
#         let(:params) do
#           {
#             q: {
#               tours_name_cont: 'tour 1',
#               start_time_lteq: DateTime.current.beginning_of_day + 5.day,
#               end_time_gteq:   DateTime.current.beginning_of_day + 5.day,
#             },
#           }
#         end
#         it 'response correct array with 200 status' do
#           expect_http_status 200
#           expect(response_body['data'].pluck('id')).to match_array [coupon_tour3.id]
#         end
#       end

#       context 'with full search params' do
#         let(:params) do
#           {
#             q: {
#               tours_id_eq:           tour1.id,
#               tours_name_cont:       'tour',
#               prefectures_name_cont: 'prefecture',
#               start_time_lteq:       DateTime.current.beginning_of_day + 2.day,
#               end_time_gteq:         DateTime.current.beginning_of_day + 2.day,
#             },
#           }
#         end
#         it 'response correct array with 200 status' do
#           expect_http_status 200
#           expect(response_body['data'].pluck('id')).to match_array [coupon_tour1.id]
#         end
#       end
#     end
#   end

#   describe 'POST /admin/coupons' do
#     let(:prefecture_ids) { create_list :prefecture, 4 }
#     let(:file) do
#       [
#         {
#           url:  'https://step-travel.s3.ap-northeast-1.amazonaws.com/store/1487f2b89d439605fcee.png',
#           type: 'details',
#         },
#         { url: 'https://step-travel.s3.ap-northeast-1.amazonaws.com/store/1487f8aac325234543gg.png' },
#       ]
#     end
#     let(:base_params) do
#       {
#         start_time:       DateTime.current + 1.day,
#         end_time:         DateTime.current + 2.day,
#         publish_date:     DateTime.current + 1.day,
#         is_notice:        false,
#         prefecture_ids:   prefecture_ids.pluck(:id),
#         file:             file,
#         code:             Faker::Lorem.sentence(word_count: 3),
#         name:             Faker::Tea.type,
#         company_staff_id: 1,
#         end_date:         DateTime.current + 3.day,
#         start_date:       DateTime.current,
#         tour_category_id: 1,
#         tour_company_id:  1,
#       }
#     end

#     context 'with valid params' do
#       # it 'reponse new coupon with 200 status' do
#       #   post admin_coupons_path, headers: headers, params: base_params
#       #   expect_http_status 200
#       #   expect([Coupon.count, Tour.count, Prefecture.count, Asset.count]).to eq [2, 1, 4, 2]
#       # end
#     end

#     context 'with invalid params' do
#       before { post admin_coupons_path, headers: headers, params: params }

#       context 'with tour code is empty' do
#         let(:params) { base_params.merge(code: nil) }
#         # it_behaves_like('bad request error', 'code', "can't be blank")
#       end

#       context 'with prefecture ids is empty' do
#         let(:params) { base_params.merge(prefecture_ids: nil) }

#         # it_behaves_like('bad request error', 'prefecture_ids', 'can not blank')
#       end
#     end
#   end
# end
