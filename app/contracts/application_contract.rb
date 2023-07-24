# frozen_string_literal: true

class ApplicationContract
  include ActiveModel::Model
  include ActiveModel::Validations
  include Virtus.model
  include ApplicationHelper

  attribute :attribute_changes, Hash
  attr_reader :messages

  def valid!
    return if valid?

    raise BadRequestError, fetch_messages
  end

  def messages # rubocop:disable Lint/DuplicateMethods
    return fetch_messages unless valid?
  end

  def fetch_messages
    return @messages if @messages.present?

    # get only the first error message of each attributes
    @messages = errors.messages.inject({}) do |messages, message|
      messages.merge message.first => message.second.first
    end
  end

  def self.new(options)
    options = options.merge attribute_changes: options
    object = super
    object.attribute_changes.delete 'record'
    object.attribute_changes.delete :record
    object.after_initialize
    object
  end

  def after_initialize; end
end
