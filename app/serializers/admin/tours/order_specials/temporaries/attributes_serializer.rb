# frozen_string_literal: true

class Admin::Tours::OrderSpecials::Temporaries::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :furigana, :postal_code, :address1, :address2, :telephone, :phone_number,
             :birthday, :gender
end
