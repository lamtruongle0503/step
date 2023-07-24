# frozen_string_literal: true

class Api::UserOperations::ContactOperations::Index < ApplicationOperation
  def call
    actor.user_contacts.ransack(params[:q]).result
  end
end
