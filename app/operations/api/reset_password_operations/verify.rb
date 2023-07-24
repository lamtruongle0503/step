# frozen_string_literal: true

class Api::ResetPasswordOperations::Verify < ApplicationOperation
  attr_reader :user, :verify_code

  def initialize(actor, params)
    super
    @verify_code = params[:verify_code]
    @user = User.find_by!(phone_number: params[:phone_number])
  end

  def call
    ResetPasswordContracts::Show.new(verify_code: verify_code, record: user).valid!
    user
  end
end
