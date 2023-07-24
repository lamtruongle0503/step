# frozen_string_literal: true

class Admin::TourOperations::OrderSpecialOperations::TemporaryOperations::Create < ApplicationOperation
  def initialize(actor, params)
    super
    require_params
    @tour = Tour.find(params[:tour_id])
    @order_special = @tour.tour_order_specials.find(params[:order_special_id])
  end

  def call
    file_csv? # check file csv files
    arr_import = []
    CSV.foreach(params[:files], headers: true) do |row|
      TourContracts::OrderSpecialContracts::TemporaryContracts::Create
        .new(phone_number: row.to_h['携帯番号'])
        .valid!

      arr_import << { name:                  row.to_h['氏名'],
                      furigana:              row.to_h['フリガナ'],
                      postal_code:           row.to_h['郵便番号'],
                      address1:              row.to_h['住所１'],
                      address2:              row.to_h['住所２'],
                      telephone:             row.to_h['固定電話'],
                      phone_number:          row.to_h['携帯番号'],
                      birthday:              row.to_h['生年月日'],
                      gender:                generate_age(row.to_h['性別']),
                      tour_id:               @tour.id,
                      tour_order_special_id: @order_special.id }
    end

    ActiveRecord::Base.transaction do
      Tour::Temporary.import! arr_import
    end
  end

  private

  def generate_age(text)
    case text
    when '男性'
      0
    when '女性'
      1
    else
      2
    end
  end

  def require_params
    return raise BadRequestError, files: I18n.t('models.can_not_blank') unless params[:files]
  end

  def file_csv?
    return if params[:files].content_type.include?('csv')

    raise BadRequestError, files: I18n.t('tour.file.must_be_csv')
  end
end
