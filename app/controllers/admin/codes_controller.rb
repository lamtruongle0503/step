# frozen_string_literal: true

class Admin::CodesController < ApiV1Controller
  before_action :authentication!

  def create
    render json: Admin::CodeOperations::Create.new(actor, params).call,
           serializer: Admin::Codes::CreateSerializer, root: 'codes'
  end
end
