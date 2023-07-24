# frozen_string_literal: true

class ApiV1Controller < ActionController::API
  include ApplicationHelper
  include ApiErrorHandler
  include Authorizable
end
