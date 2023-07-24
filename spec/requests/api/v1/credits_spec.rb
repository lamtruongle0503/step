# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Credits', type: :request do
  include_context 'user with authentication grant'

  describe 'POST /api/v1/credits' do
    let(:base_params) do
      {
        card_number: '4242424242424242',
        exp_date:    DateTime.current + 6.years,
        cvc_number:  999,
        user_name:   'Tran Van A',
      }
    end

    context 'with valid params' do
      before do
        post api_v1_credits_path, params: base_params, headers: headers
      end

      context 'with customer_id does not exist' do
        it 'reponse new credits with 200 status' do
          expect_http_status 200
        end
      end

      context 'with customer_id already exist' do
        let(:customer_id) { StripeService.create_customer(current_user).id }
        let!(:credit) { create :credit, customer_id: customer_id, user: current_user }

        it 'reponse new credits with 200 status' do
          expect_http_status 200
          expect(current_user.credit).to eq credit
        end
      end
    end

    context 'with invalid params' do
      before do
        post api_v1_credits_path, params: params, headers: headers
      end

      context 'with card_number is invalid ' do
        let(:params) { base_params.merge(card_number: 'invalid') }

        it_behaves_like('bad request error', 'card_number', 'is not a number')
      end

      context 'with exp_date is invalid ' do
        let(:params) { base_params.merge(exp_date: 'invalid') }

        it 'response bad request with error messages' do
          expect_http_status :bad_request
          expect(response_body['messages']).to eq 'invalid date'
        end
      end

      context 'with cvc_number is invalid ' do
        let(:params) { base_params.merge(cvc_number: '') }

        it_behaves_like('bad request error', 'cvc_number', "can't be blank")
      end

      context 'with user_name is blank ' do
        let(:params) { base_params.merge(user_name: nil) }

        it_behaves_like('bad request error', 'user_name', "can't be blank")
      end
    end
  end
end
