# frozen_string_literal: true

class Admin::ContactOperations::Index < ApplicationOperation
  def call
    authorize Contact

    @q        = Contact.includes(:contact_category).ransack(params[:q])
    @contacts = @q.result(distinct: true).newest.page(params[:page])
  end
end
