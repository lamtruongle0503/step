# frozen_string_literal: true

RSpec.shared_context 'user with authentication grant' do
  let(:current_user) { create :user }
  let(:current_admin) { create :admin }
  let(:payload) { Users::AttributesSerializer.new(current_user).as_json.merge(server_time: Time.zone.now) }
  let(:access_token) { JsonWebToken.encode(payload) }
  let(:headers) do
    { HTTP_AUTHORIZATION: access_token }
  end
end

RSpec.shared_context 'admin with authentication grant' do
  let(:current_admin) { create :admin }
  let(:payload) { Admin::Admins::AttributesSerializer.new(current_admin).as_json.merge(server_time: Time.zone.now) }
  let(:access_token) { JsonWebToken.encode(payload) }
  let(:headers) do
    { HTTP_AUTHORIZATION: access_token }
  end
end
