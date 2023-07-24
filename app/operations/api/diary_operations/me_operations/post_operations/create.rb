# frozen_string_literal: true

class Api::DiaryOperations::MeOperations::PostOperations::Create < ApplicationOperation
  def call
    DiaryContracts::PostContracts::Create.new(post_params).valid!
    ActiveRecord::Base.transaction do
      @post = actor.posts.create!(post_params)
      upload(@post)
    end
  end

  private

  def post_params
    params.permit(:diary_category_id, :contents, :like_count, :background_color, :type_post, :location)
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
