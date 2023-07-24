# frozen_string_literal: true

module ApiHelper
  def response_body
    JSON.parse(response.body)
  end

  def error_message
    response_body['error']['message']
  end

  def expect_error_message(message)
    expect(error_message).to eq message
  end

  def expect_http_status(http_status)
    expect(response).to have_http_status(http_status)
  end
end
