# frozen_string_literal: true

class AwsSqsService
  attr_reader :sqs_client

  def initialize
    @sqs_client = Aws::SQS::Client.new
  end

  def send(message_group_id, title, content, recipient)
    sqs_client.send_message({
                              queue_url:        ENV['SQS_QUEUE_URL'],
                              message_group_id: message_group_id, # SMS or EMAIL
                              message_body:     message_body(title, content, recipient),
                            })
  end

  private

  def message_body(title, content, recipient)
    # title - optional - empty when queue_group_id = 'SMS'
    # content - require
    # recipient - email or phone_number
    {
      title:     title,
      content:   content,
      recipient: recipient,
    }.to_json
  end
end
