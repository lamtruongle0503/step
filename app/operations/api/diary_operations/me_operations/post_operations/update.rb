# frozen_string_literal: true

class Api::DiaryOperations::MeOperations::PostOperations::Update < ApplicationOperation
  def initialize(actor, params)
    super
    @post = actor.posts.find(params[:id])
  end

  def call
    DiaryContracts::PostContracts::Update.new(post_params).valid!
    ActiveRecord::Base.transaction do
      @post.update!(post_params.merge(status: Post.statuses[:no_approved]))
      upload(@post)
    end
    @post.reload
  end

  private

  def post_params
    params.permit(:diary_category_id, :contents, :background_color, :type_post, :location)
  end

  def upload(post)
    return unless params[:file]

    if params[:file].is_a? Array
      params[:file].each do |file|
        upload_multiple_file(post, file[:url], file[:type], file[:file_type])
      end
    else
      upload_multiple_file(post, params[:file][:url], params[:file][:type], params[:file][:file_type])
    end
  end
end
