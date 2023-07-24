# frozen_string_literal: true

class Admin::UserOperations::Update < ApplicationOperation
  attr_reader :user

  def initialize(actor, params)
    super
    @user = User.find(params[:id])
  end

  def call
    authorize User

    UserContracts::Update.new(user_params.merge(record: user)).valid!
    update_user!
    user
  end

  private

  def update_user!
    user.update!(user_params)
  end

  def user_params
    params.permit(
      :email,
      :phone_number,
      :first_name,
      :first_name_kana,
      :last_name,
      :last_name_kana,
      :gender,
      :birth_day,
      :post_code,
      :address1,
      :address2,
      :telephone,
      :note,
      :is_dm,
      :status,
    )
  end
end
