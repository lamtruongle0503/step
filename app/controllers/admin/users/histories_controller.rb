# frozen_string_literal: true

class Admin::Users::HistoriesController < ApiV1Controller
  before_action :authentication!

  def index
    user = Admin::UserOperations::HistoryOperations::Index.new(actor, params).call
    render json: user,
           serializer: Admin::Users::Histories::IndexSerializer, root: 'data'
  end
end
