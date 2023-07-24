# frozen_string_literal: true

class UniquenessValidator < ActiveRecord::Validations::UniquenessValidator
  def initialize(options)
    super
    @klass = options[:model] if options[:model]
  end

  def validate_each(record, attribute, value)
    record_org = record

    # Change attribute to a new value
    if record_org.try :record
      recover_record = record.record.attributes
      record = record_org.record
      @klass = record.class
    else
      record = options[:model].new(attribute => value)
    end

    # Change attribute for scopes which will be changed
    record_org[:attribute_changes].select! { |attr| record.attributes.keys.include?(attr) }
    record.assign_attributes(record_org[:attribute_changes])
    super

    # Recover `record` after assign attribute change
    record.assign_attributes(recover_record) if recover_record

    # Detect error if it appear
    return unless record.errors[attribute.to_sym].present?

    record_org.errors.add(
      attribute, options[:message] || I18n.t('models.exists'),
      options.except(:case_sensitive, :scope, :conditions).merge(value: value)
    )
  end
end
