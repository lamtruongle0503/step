# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::Users::Downloads', type: :request do
  include_context 'admin with authentication grant'

  describe 'GET /admin/users/downloads' do
    context 'when performing with list exist users ', :dox do
      let!(:users) { create_list :user, 10 }

      before { post admin_downloads_path, headers: headers }

      it 'return headers with Content-Type is text/csv; charset=shift_jis' do
        expect_http_status :ok
        expect(response.header['Content-Type']).to eq 'text/csv; charset=shift_jis'
      end
    end
  end
end
