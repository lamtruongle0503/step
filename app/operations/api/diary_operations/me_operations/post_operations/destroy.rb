# frozen_string_literal: true

class Api::DiaryOperations::MeOperations::PostOperations::Destroy < ApplicationOperation
  def initialize(actor, params)
    super
    @post = actor.posts.find(params[:id])
  end

  def call
    ActiveRecord::Base.transaction do
      @post.destroy!
    end
  end
end
