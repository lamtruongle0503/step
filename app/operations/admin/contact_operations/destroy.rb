# frozen_string_literal: true

class Admin::ContactOperations::Destroy < ApplicationOperation
  def call
    authorize Contact

    contact = Contact.find(params[:id])
    contact.destroy
  end
end
