# frozen_string_literal: true

class Admin::ContactOperations::Create < ApplicationOperation
  def call
    authorize Contact

    ContactContracts::Create.new(contact_params).valid!
    Contact.create!(contact_params)
  end

  private

  def contact_params
    params.permit(:code, :contact_category_id, :contents, :phone_number, :email, :created_at, :user, :status,
                  :furigana, :todo)
  end
end
