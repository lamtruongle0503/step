# frozen_string_literal: true

module Authorizable
  extend ActiveSupport::Concern

  def authentication!
    verify_token!
    verify_api_key!
    verify_actor!
  end

  def authentication_ec!
    verify_token_ec!
    verify_api_key_ec!
    verify_actor_ec!
  end

  def actor # rubocop:disable Metrics/PerceivedComplexity
    @actor ||= if auth_token[:module_name] == Admin.name && request.path.starts_with?('/admin')
                 Admin.find(auth_token[:id])
               elsif auth_token[:module_name] == User.name && request.path.starts_with?('/api')
                 User.find(auth_token[:id])
               elsif auth_token[:module_name] == CompanyStaff.name && request.path.starts_with?('/admin')
                 CompanyStaff.find(auth_token[:id])
               end
  end

  def actor_ec # rubocop:disable Metrics/PerceivedComplexity
    return @actor_ec = nil if auth_token_ec.blank?

    @actor_ec ||=
      if auth_token_ec[:module_name] == Admin.name && request.path.starts_with?('/admin')
        Admin.find(auth_token_ec[:id])
      elsif auth_token_ec[:module_name] == User.name && request.path.starts_with?('/api')
        User.find(auth_token_ec[:id])
      elsif auth_token_ec[:module_name] == CompanyStaff.name && request.path.starts_with?('/admin')
        CompanyStaff.find(auth_token_ec[:id])
      end
  end

  def api_key
    @api_key ||= http_token
  end

  private

  def verify_token!
    raise UnauthorizedError, authorization: I18n.t('authorized.unauthorized') unless valid_token?
  end

  def verify_token_ec!
    return {} unless valid_token_ec?
  end

  def verify_api_key!
    raise UnauthorizedError, access_token: I18n.t('invalid.access_token') unless api_key
  end

  def verify_api_key_ec!
    return nil unless api_key
  end

  def verify_actor!
    raise UnauthorizedError, I18n.t('authorized.unauthorized') unless actor_ec
  end

  def verify_actor_ec!
    return nil unless actor_ec
  end

  def auth_token
    @auth_token ||= JsonWebToken.decode(http_token)
  end

  def auth_token_ec
    @auth_token_ec ||= (http_token.present? ? JsonWebToken.decode(http_token) : nil)
  end

  def http_token
    request.headers[:HTTP_AUTHORIZATION]
  end

  def valid_token?
    http_token && auth_token
  end

  def valid_token_ec?
    http_token && auth_token_ec
  end
end
