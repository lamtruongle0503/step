# frozen_string_literal: true

class Api::NewOperations::TopHeadlineOperations::Index < ApplicationOperation
  def call
    NewsFeed.newest.first(10)
  end
end
