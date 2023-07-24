# frozen_string_literal: true

class Api::Users::Contacts::AttributeSerializer < ApplicationSerializer
  attributes :id, :phone_number, :full_name, :furigana, :first_name, :last_name,
             :gender, :birth_day, :email, :diary_flg, :telephone, :post_code,
             :address1, :address2, :first_name_kana, :last_name_kana,
             :furigana, :full_name
end
