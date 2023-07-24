# frozen_string_literal: true

class Api::UserOperations::Verify < ApplicationOperation
  attr_reader :user, :verify_code

  def initialize(actor, params)
    super
    @verify_code = params[:verify_code]
    @user = User.find_by!(phone_number: params[:phone_number])
  end

  def call
    UserContracts::Verify.new(verify_code: verify_code, record: user).valid!
    user.update!(
      verify_code: nil,
      expired_at:  nil,
      is_verify:   true,
    )
    user
  end
end
