# frozen_string_literal: true

module ApiErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError do |e|
      Rails.logger.error('Internal server error occurred.')
      Rails.logger.error("  type: #{e.class.name}")
      Rails.logger.error("  message: #{e.message}")
      Rails.logger.error('  backtrace:')
      Rails.logger.error("    #{e.backtrace.join("\n    ")}")
      ExceptionNotifier.notify_exception(e)
      error_response_with_type(e.message, :internal_server_error, e.class.name)
    end

    rescue_from BadRequestError do |e|
      ExceptionNotifier.notify_exception(e)
      error_response(e.errors, :bad_request)
    end

    rescue_from UnauthorizedError do |e|
      ExceptionNotifier.notify_exception(e)
      error_response(e.errors, :unauthorized)
    end

    rescue_from Pundit::NotAuthorizedError do |e|
      ExceptionNotifier.notify_exception(e)
      error_response(I18n.t('permission.denied'), :forbidden)
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      ExceptionNotifier.notify_exception(e)
      error_response(I18n.t('models.does_not_exists'), :not_found)
    end

    rescue_from ActiveRecord::InvalidForeignKey do |e|
      ExceptionNotifier.notify_exception(e)
      error_response(I18n.t('invalid.foreign_key'), :invalid_foreign_key)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      ExceptionNotifier.notify_exception(e)
      error_response(e.message, :bad_request)
    end

    rescue_from NotImplementedError do |e|
      ExceptionNotifier.notify_exception(e)
      error_response(e.message, :not_implemented)
    end

    rescue_from ArgumentError do |e|
      ExceptionNotifier.notify_exception(e)
      error_response(e.message, 400)
    end
  end

  private

  def error_response(errors, status)
    keys = errors.is_a?(String) ? :messages : :errors
    render json: { keys => errors }, status: status
  end

  def error_response_with_type(errors, status, type)
    render json: {
      type:     type,
      messages: errors,
    }, status: status
  end
end
