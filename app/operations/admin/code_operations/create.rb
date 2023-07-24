# frozen_string_literal: true

class Admin::CodeOperations::Create < ApplicationOperation
  def call
    CodeContracts::Create.new({ name_model: params[:name_model] }).valid!
    code = generate_code(params[:name_model])
    { code: code }
  end
end
