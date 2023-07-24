# frozen_string_literal: true

# require 'rails_helper'

# RSpec.describe 'Api::V1::Auths', type: :request do
#   describe 'POST /api/v1/auths' do
#     let(:user) { create :user }
#     let(:base_params) do
#       {
#         phone_number: user.phone_number,
#         password:     user.password,
#       }
#     end
#     context 'with valid phone_number and password' do
#       it 'reponse access token with 200 status' do
#         post api_v1_auths_path, params: base_params
#         token = response_body['access_token']
#         segments = token.split('.')
#         expect_http_status 200
#         expect(token).to be_kind_of(String)
#         expect(segments.size).to eql(3)
#       end
#     end

#     context 'with invalid phone_number or password' do
#       before { post api_v1_auths_path, params: params }

#       context 'with invalid phone_number' do
#         let(:params) { base_params.merge(phone_number: '0123456789') }

#         it_behaves_like('bad request error', 'email_password', 'email/password invalid')
#       end

#       context 'with invalid password' do
#         let(:params) { base_params.merge(password: 'invalid') }

#         it_behaves_like('bad request error', 'email_password', 'email/password invalid')
#       end
#     end
#   end
# end
