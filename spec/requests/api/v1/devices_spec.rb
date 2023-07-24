# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Devices', type: :request do
  include_context 'user with authentication grant'

  describe 'POST /api/v1/devices' do
    let(:base_params) do
      {
        os:           'Ubuntu 18.04',
        device_token: 'abc_xyz',
      }
    end

    context 'with valid params' do
      it 'reponse new devices with 200 status' do
        post api_v1_devices_path, params: base_params, headers: headers
        expect_http_status 200
      end
    end

    context 'with invalid params' do
      before do
        post api_v1_devices_path, params: params, headers: headers
      end

      context 'with os is blank ' do
        let(:params) { base_params.merge(os: nil) }

        it_behaves_like('bad request error', 'os', "can't be blank")
      end

      context 'with device_token is blank ' do
        let(:params) { base_params.merge(device_token: nil) }

        it_behaves_like('bad request error', 'device_token', "can't be blank")
      end
    end
  end
end
