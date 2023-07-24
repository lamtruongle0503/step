# frozen_string_literal: true

class Admin::Users::MetaController < ApiV1Controller
  before_action :authentication!

  def show
    user = Admin::UserOperations::MetaOperations::Show.new(actor, params).call
    render json:       user,
           serializer: ::Admin::Users::Meta::ShowSerializer
  end
end
