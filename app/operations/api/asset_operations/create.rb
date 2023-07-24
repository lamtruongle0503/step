# frozen_string_literal: true

class Api::AssetOperations::Create < ApplicationOperation
  def call
    raise BadRequestError, video_url: I18n.t('models.can_not_blank') unless params[:video_url]

    @asset = Asset.find_by!(url: params[:video_url])
    module_asset = @asset.assets_module&.module

    return unless module_asset
    return if [Notification.name, Category.name, User.name].include?(module_asset.class.name)

    module_asset.assets.create!(url: params[:thumbnail_url], type: Asset::THUMBNAIL, file_type: 'thumbnail')
  end
end
