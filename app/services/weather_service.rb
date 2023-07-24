# frozen_string_literal: true

class WeatherService
  attr_reader :s3_client

  def initialize
    @client = Aws::DynamoDB::Client.new
  end

  def query_by_module(module_type, module_name, _prefecture_name)
    query_item = {
      table_name:                  'MainStack-WeatherReports',
      index_name:                  'report-by-district-prefecture',
      key_condition_expression:    'module_type = :module_type AND module_name = :module_name',
      expression_attribute_values: {
        ':module_name' => module_name,
        ':module_type' => module_type,
      },
    }
    @client.query(query_item)
  end
end
