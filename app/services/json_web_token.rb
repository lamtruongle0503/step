# frozen_string_literal: true

class JsonWebToken
  class << self
    JWT_SECRET = ENV['JWT_SECRET']
    def encode(payload, exp = Time.zone.now)
      payload[:exp] = expire_token(exp)
      JWT.encode(payload, JWT_SECRET)
    end

    def decode(token)
      raise UnauthorizedError, { access_token: I18n.t('invalid.access_token') } if token.nil?

      body = JWT.decode(token, JWT_SECRET)[0]
      HashWithIndifferentAccess.new body
    rescue JWT::ExpiredSignature
      raise UnauthorizedError, ({ access_token: 'Token expired' })
    end

    private

    def expire_token(exp = Time.zone.now)
      (exp + 1.years).to_i
    end
  end
end
