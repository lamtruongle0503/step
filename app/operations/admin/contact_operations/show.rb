# frozen_string_literal: true

class Admin::ContactOperations::Show < ApplicationOperation
  def call
    authorize Contact

    @contact = Contact.find(params[:id])
  end
end
