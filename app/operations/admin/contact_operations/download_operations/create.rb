# frozen_string_literal: true

require 'csv'

class Admin::ContactOperations::DownloadOperations::Create < ApplicationOperation
  def call
    generate_csv
  end

  private

  def contacts
    @contacts ||= Contact.ransack(params[:q]).result(distinct: true).newest
  end

  def generate_csv
    CSV.generate do |csv|
      csv << I18n.t(:contacts, scope: [:headers])
      contacts.each_with_index do |record, i|
        arr = []
        arr << [i + 1, record.code, record.user, record.furigana, record.contact_category&.name,
                record.contents, record.todo, record.phone_number, record.email,
                record.created_at.strftime('%Y/%m/%d %H:%M:%S')]
        arr << if record.open?
                 '新規'
               elsif record.inprogress?
                 '対応中'
               elsif record.done?
                 '対応済み'
               elsif record.pending?
                 '保留'
               end

        csv << arr.flatten
      end
    end
  end
end
