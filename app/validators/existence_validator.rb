# frozen_string_literal: true

class ExistenceValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    model = options[:with] || attribute.to_s.titleize.delete(' ')
    model = model == User.name ? User.all : model.constantize
    return record.errors.add(attribute, I18n.t('models.can_not_blank')) if value.blank?

    return unless model.find_by(id: value).blank?

    record.errors.add(attribute,
                      I18n.t('models.does_not_exists', subject: ''))
  end
end
