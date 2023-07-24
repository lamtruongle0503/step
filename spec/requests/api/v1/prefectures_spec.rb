# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User::Prefectures', type: :request do
  include_context 'user with authentication grant'

  describe 'GET /api/v1/prefectures' do
    context 'with prefectures' do
      let!(:prefectures) { create_list :prefecture, 10 }

      it 'response correct array with 200 status' do
        get '/api/v1/prefectures', headers: headers
        expect_http_status 200
        expect(response_body.pluck('id')).to match_array prefectures.pluck(:id)
      end
    end

    context 'with empty prefectures' do
      it 'response empty array with 200 status' do
        get '/api/v1/prefectures', headers: headers
        expect_http_status 200
        expect(response_body.pluck('id')).to match_array []
      end
    end
  end
end
