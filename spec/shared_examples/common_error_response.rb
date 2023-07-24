# frozen_string_literal: true

RSpec.shared_examples 'bad request error' do |field, message|
  let(:error) do
    {
      'errors' => { field => message },
    }
  end

  it "response 400 status and error #{message}" do
    expect_http_status 400
    expect(response_body).to eq error
  end
end
