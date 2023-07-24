# frozen_string_literal: true

module ApplicationHelper # rubocop:disable Metrics/ModuleLength
  include OrderHelper
  include TourHelper
  include HotelHelper
  include TourOrderHelper
  include ProductHelper
  include DiaryHelper

  def upload_multiple_file(object, url, type, file_type)
    object.assets&.destroy_all
    asset = Asset.create!(url: url, type: type, file_type: file_type)
    object.assets_modules.create!(asset_id: asset.id)
  end

  def upload_file(object, url, type, file_type)
    object.asset&.destroy!
    asset = Asset.create!(url: url, type: type, file_type: file_type)
    object.create_assets_module!(asset_id: asset.id)
  end

  def pagination_dict(object)
    {
      total_page: object.total_pages,
    }
  end

  def generate_code(model_name) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/AbcSize
    case model_name
    when Tour.name
      prefix = SecureRandom.hex(1).upcase
      generate_last_code(prefix, Tour.name)
    when User.name
      prefix = 'USER'
      generate_last_code(prefix, User.name)
    when Product.name
      prefix = 'PRD'
      generate_last_code(prefix, Product.name)
    when Contact.name
      prefix = ''
      generate_last_code(prefix, Contact.name)
    when Category.name
      prefix = 'CAT'
      generate_last_code(prefix, Category.name)
    when Order.name
      prefix = SecureRandom.hex(3).upcase
      generate_last_code(prefix, Order.name)
    when Campaign.name
      prefix = 'CAM'
      generate_last_code(prefix, Campaign.name)
    when Hotel::Order.name
      prefix = 'ST'
      generate_last_code(prefix, Hotel::Order.name)
    when Tour::Order.name
      prefix = 'ST'
      generate_last_code(prefix, Tour::Order.name)
    when Hotel::Request.name
      prefix = 'RQ'
      generate_last_code(prefix, Hotel::Request.name)
    when Agency.name
      prefix = 'H'
      generate_last_code(prefix, Agency.name)
    end
  end

  def generate_ranking(model_name)
    case model_name
    when Category.name
      generate_last_ranking(Category.name).to_i
    when Campaign.name
      generate_last_ranking(Campaign.name).to_i
    end
  end

  def generate_last_code(prefix, model_name) # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength
    case model_name
    when Tour.name
      loop do
        suffix = "#{I18n.l(Time.now, format: :strfmonth)}-#{SecureRandom.hex(1).upcase}"
        code = prefix + suffix

        break code unless Tour.with_deleted.where(code: code).exists?
      end
    when Order.name
      loop do
        suffix = I18n.l(Time.now, format: :strfdate)
        code = "#{prefix}-#{suffix}"

        break code unless Order.with_deleted.where(code: code).exists?
      end
    when Hotel::Order.name
      last_code = model_name.constantize.where.not(order_no: [nil, '']).order(:order_no).last&.order_no
      suffix = last_code&.last(7).to_i
      suffix = (suffix + 1).to_s.rjust(7, '0')
      prefix + suffix
    when Tour::Order.name
      last_code = model_name.constantize.where.not(order_no: [nil, '']).order(:order_no).last&.order_no
      suffix = last_code&.last(6).to_i
      suffix = (suffix + 1).to_s.rjust(6, '0')
      prefix + suffix
    when Hotel::Request.name
      last_code = model_name.constantize.where.not(request_no: [nil, '']).order(:request_no).last&.request_no
      suffix = last_code&.last(7).to_i
      suffix = (suffix + 1).to_s.rjust(7, '0')
      prefix + suffix
    when Agency.name
      last_code = model_name.constantize.where.not(code: [nil, '']).order(:code).last&.code
      suffix = last_code&.last(5).to_i
      suffix = (suffix + 1).to_s.rjust(5, '0')
      prefix + suffix
    else
      last_code = model_name.constantize.where.not(code: [nil, '']).order(:code).last&.code
      suffix = last_code&.last(6).to_i
      suffix = (suffix + 1).to_s.rjust(6, '0')
      prefix + suffix
    end
  end

  def generate_last_ranking(model_name)
    last_ranking = model_name.constantize.where.not(ranking: [nil]).order(:ranking).last&.ranking.to_i
    last_ranking + 1
  end

  def build_notifications_users(notification) # rubocop:disable Metrics/PerceivedComplexity
    # Get users by gender
    @users = if params[:is_gender]
               User.receive_notification
             elsif params[:gender] == 'male'
               User.receive_notification.male
             elsif params[:gender] == 'female'
               User.receive_notification.female
             else
               User.receive_notification.other
             end

    # Get users of month
    if notification.month_birthday.present?
      user_ids = []
      notification.month_birthday.each do |month|
        u_id = @users.receive_notification.where('EXTRACT(MONTH FROM birth_day) = ?', month).pluck(:id)
        user_ids.concat(u_id)
      end
      @users = User.where(id: user_ids)
    end

    # Get users by prefecture
    unless params[:is_prefecture]
      prefectures_name = Prefecture.where(id: params[:prefecture_ids]).pluck(:name)
      @users = @users.receive_notification.where('address1 ~* ?', prefectures_name.join('|'))
    end
    @users.pluck(:id).map { |id| { notification_id: notification.id, user_id: id } }
  end

  def count_remaining_product(user_id, product_size_id)
    return 0 unless user_id

    OrderProduct.joins(:order)
                .where(order:           { order_status: Order::WAITING, user_id: user_id },
                       product_size_id: product_size_id).sum(:number)
  end

  def count_record(record)
    {
      total_record: record.count,
    }
  end
end
