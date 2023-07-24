# frozen_string_literal: true

class Admin::Ecommerces::Orders::IndexSerializer < Admin::Ecommerces::Orders::AttributesSerializer
  attributes :full_name, :full_name_furigana

  def full_name
    object.user.full_name
  end

  def full_name_furigana
    object.user.furigana
  end
end
