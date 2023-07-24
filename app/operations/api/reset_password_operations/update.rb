# frozen_string_literal: true

module Api::ResetPasswordOperations
  class Update < Verify
    def call
      ResetPasswordContracts::Show.new(verify_code: verify_code, record: user).valid!
      update_password!
      user
    end

    private

    def update_password!
      ResetPasswordContracts::Update.new(reset_password_params).valid!
      user.update!(
        password:    reset_password_params[:password],
        verify_code: nil,
        expired_at:  nil,
      )
    end

    def reset_password_params
      params.permit(
        :password,
        :password_confirmation,
      )
    end
  end
end
