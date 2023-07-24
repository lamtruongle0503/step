# frozen_string_literal: true

class Admin::ContactOperations::Update < ApplicationOperation
  def call
    authorize Contact

    ContactContracts::Update.new(contact_params).valid!
    contact = Contact.find(params[:id])
    contact.update!(contact_params)
    contact
  end

  private

  def contact_params
    params.permit(
      :contact_category_id,
      :contents,
      :phone_number,
      :email,
      :created_at,
      :user,
      :status,
      :furigana,
      :todo,
    )
  end
end
