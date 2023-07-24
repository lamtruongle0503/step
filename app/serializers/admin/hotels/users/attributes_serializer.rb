# frozen_string_literal: true

class Admin::Hotels::Users::AttributesSerializer < ApplicationSerializer
  attributes :id, :full_name, :furigana, :first_name, :last_name, :first_name_kana, :last_name_kana,
             :gender, :post_code, :phone_number, :telephone, :address1, :address2, :email, :birth_day,
             :point
end
