# frozen_string_literal: true

# require 'rails_helper'

# RSpec.describe 'Api::V1::Users', type: :request do
#   include_context 'user with authentication grant'

#   describe 'GET /api/v1/users' do
#     context 'with users' do
#       let!(:users) { create_list :user, 10 }

#       it 'response array with 200 status' do
#         get api_v1_users_path, headers: headers
#         expect_http_status 200
#         expect(response_body.pluck('id')).to match_array User.pluck(:id)
#       end
#     end

#     context 'with only current_user ' do
#       before { User.destroy_all }

#       it 'response empty array with 200 status' do
#         get api_v1_users_path, headers: headers
#         expect_http_status 200
#         expect(response_body.pluck('id')).to eq [current_user.id]
#       end
#     end
#   end

#   describe 'GET /api/v1/users/:id' do
#     context 'with correct user id' do
#       let(:user) { create :user }
#       let(:customer_id) { StripeService.create_customer(user).id }
#       let!(:card_info1) do
#         StripeService.create_credit_card(customer_id, 'user1', 4_242_424_242_424_242, 8, 2026, 999)
#       end
#       let!(:card_info2) do
#         StripeService.create_credit_card(customer_id, 'user1', 4_000_056_655_665_556, 10, 2026, 888)
#       end
#       let!(:credit) { create :credit, customer_id: customer_id, user: user }

#       it 'response array with 200 status' do
#         get api_v1_user_path(user), headers: headers
#         expect_http_status 200
#         expect(response_body['user']['id']).to eq user.id
#         expect(response_body['credits_card']).to eq [{ card_info1.id => card_info1.last4, 'exp_date' => '08/26' }, { card_info2.id => card_info2.last4, 'exp_date' => '10/26' }, { 'default_card' => nil }]
#       end
#     end

#     context 'with wrong user id' do
#       it 'response array with 200 status' do
#         get api_v1_user_path(id: :invalid), headers: headers
#         expect_http_status :not_found
#       end
#     end
#   end

#   describe 'POST /api/v1/users' do
#     let(:base_params) do
#       {
#         email:                 'user@gmail.com',
#         password:              'Aa@123456',
#         password_confirmation: 'Aa@123456',
#         phone_number:          '0877654121',
#         first_name:            'user',
#         first_name_kana:       'name',
#         last_name:             'かた',
#         last_name_kana:        'かな',
#         gender:                'male',
#         birth_day:             '22/02/2022',
#         post_code:             '88888888',
#         address1:              'danang',
#         address2:              'hochiminh',
#         verify_code:           '123456',
#         telephone:             '0123456789',
#       }
#     end

#     context 'with valid params' do
#       let!(:prefecture1) { create :prefecture }
#       let!(:prefecture2) { create :prefecture }
#       let!(:prefecture3) { create :prefecture }
#       it 'reponse new user with 200 status' do
#         post api_v1_users_path, params: base_params
#         expect_http_status 200
#       end
#     end

#     context 'with invalid params' do
#       before do
#         post api_v1_users_path, params: params
#       end

#       context 'with email is invalid ' do
#         let(:params) { base_params.merge(email: 'invalid') }

#         it_behaves_like('bad request error', 'email', 'is invalid')
#       end

#       context 'with phone_number is invalid ' do
#         let(:params) { base_params.merge(phone_number: 'errors') }

#         it_behaves_like('bad request error', 'phone_number', 'is invalid')
#       end

#       context 'with password_confirmation is not match ' do
#         let(:params) { base_params.merge(password_confirmation: '1234567') }

#         it_behaves_like('bad request error', 'password_confirmation', "doesn't match Password")
#       end
#     end
#   end

#   describe 'PUT /api/v1/users/:id' do
#     let(:user) { create :user }
#     let(:base_params) do
#       {
#         email:                 'user@gmail.com',
#         password:              'Aa@123456',
#         password_confirmation: 'Aa@123456',
#         phone_number:          '0877654121',
#         first_name:            'user',
#         first_name_kana:       'name',
#         last_name:             'かた',
#         last_name_kana:        'かな',
#         gender:                'male',
#         birth_day:             '22/02/2022',
#         post_code:             '88888888',
#         address1:              'danang',
#         address2:              'hochiminh',
#         verify_code:           '123456',
#         telephone:             '0123456789',
#       }
#     end

#     context 'with valid params' do
#       it 'reponse new user with 200 status' do
#         put api_v1_user_path(user), headers: headers, params: base_params
#         expect_http_status 200
#       end
#     end
#   end
# end
