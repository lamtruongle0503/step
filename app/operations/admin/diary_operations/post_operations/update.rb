# frozen_string_literal: true

class Admin::DiaryOperations::PostOperations::Update < ApplicationOperation
  attr_reader :post

  def initialize(actor, params)
    super
    @post = Post.find(params[:id])
  end

  def call
    AdminContracts::DiaryContracts::PostContracts::Update.new(status: params[:status]).valid!
    ActiveRecord::Base.transaction do
      post.update!(params_post)
    end
  end

  private

  def params_post
    params.permit(:status)
  end
end
