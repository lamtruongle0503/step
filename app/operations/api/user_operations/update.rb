# frozen_string_literal: true

class Api::UserOperations::Update < ApplicationOperation
  attr_reader :user

  def initialize(actor, params)
    super
    @user = actor
  end

  def call
    UserContracts::Update.new(user_params.merge(record: user)).valid!
    ActiveRecord::Base.transaction do
      update_user!
      update_user_address!
      upload(user)
    end
    { user: user, credits_card: credits_card }
  end

  private

  def update_user!
    user.update!(user_params)
  end

  def update_user_address!
    if check_first_record?
      new_address_params = address_params.merge(is_default: true)
      user.addresses.create!(new_address_params)
    else
      user.addresses.update_all(is_default: false)
      address = user.addresses&.order(created_at: :asc)&.first
      full_name = "#{params[:first_name]}　#{params[:last_name]}"
      address&.update!(address_params.merge(full_name: full_name))
    end
  end

  def check_first_record?
    user.addresses.blank?
  end

  def credits_card
    customer_id = user.credit&.customer_id
    StripeService.get_list_credit_card(customer_id) if customer_id
  end

  def user_params
    params.permit(
      :email,
      :password,
      :password_confirmation,
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
      :verify_code,
      :telephone,
      :nick_name,
    )
  end

  def address_params
    {
      postcode:   params[:post_code],
      address1:   params[:address1],
      address2:   params[:address2],
      full_name:  "#{params[:first_name]}　#{params[:last_name]}",
      is_default: true,
      telephone:  params[:phone_number],
    }
  end

  def upload(user)
    return unless params[:file]

    upload_file(user, params[:file][:url], params[:file][:type], params[:file][:file_type])
  end
end
