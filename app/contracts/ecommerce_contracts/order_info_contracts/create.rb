# frozen_string_literal: true

class EcommerceContracts::OrderInfoContracts::Create < EcommerceContracts::OrderInfoContracts::Base
  attribute :user, User

  validate :must_in_user_address, :post_code_must_be_valid

  def must_in_user_address
    return if user.addresses.pluck(:id).include?(address_id) || address_id.blank?

    errors.add :address, I18n.t('addresses.must_in_user_address')
  end

  def post_code_must_be_valid
    postcode = Address.find_by(id: address_id)&.postcode
    return errors.add :address, I18n.t('addresses.must_setup_address') if postcode.blank?
    return errors.add :address, I18n.t('addresses.post_code_must_be_valid') unless ZipCodeJp.find(postcode)

    addresses       = ZipCodeJp.find(postcode)
    prefecture_name = addresses.is_a?(Array) ? addresses.first.prefecture : addresses.prefecture

    errors.add :postcode, I18n.t('addresses.post_code_must_be_valid') unless prefecture_name
  end
end
