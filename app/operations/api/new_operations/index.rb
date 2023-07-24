# frozen_string_literal: true

class Api::NewOperations::Index < ApplicationOperation
  def call
    @q = NewsFeed.ransack(params[:q])
    @news = @q.result(distinct: true).newest.page(params[:page])
  end
end
