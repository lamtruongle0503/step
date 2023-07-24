# frozen_string_literal: true

require 'csv'

class Admin::UserOperations::DownloadOperations::Create < ApplicationOperation
  def call
    generate_csv
  end

  private

  def users
    @users ||= User.order(:id).search_by(params[:q])
  end

  def generate_csv # rubocop:disable Metrics/PerceivedComplexity, Metrics/MethodLength
    CSV.generate do |csv|
      csv << I18n.t(:users, scope: [:headers])
      users.each do |record|
        arr = []
        arr << [record.id, record.full_name, record.furigana, record.phone_number.to_s,
                record.created_at.strftime('%Y/%m/%d %H:%M:%S')]
        arr << if record.male?
                 '男性'
               elsif record.female?
                 '女性'
               elsif record.other?
                 'その他'
               end
        arr << [record.birth_day, record.age, record.post_code, record.address1, record.address2,
                record.telephone, record.email]

        arr << if record.is_dm?
                 '可'
               else
                 '否'
               end
        arr << case record.status
               when User::APP
                 'アプリ会員'
               when User::FRIEND
                 '友の会'
               when User::EXHIBITION
                 '展示会'
               when User::STATUS_OTHER
                 'その他'
               end
        arr << record.note
        csv << arr.flatten
      end
    end
  end
end
