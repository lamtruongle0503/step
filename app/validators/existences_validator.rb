# frozen_string_literal: true

class ExistencesValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, values)
    active = options[:active] || false
    model = options[:with] || attribute.to_s.titleize.delete(' ')
    model = model == User.name && !active ? User.all : model.constantize
    return record.errors.add(attribute, I18n.t('models.can_not_blank')) if values.blank?

    return unless model.where(id: values).count != values.size

    record.errors.add(attribute,
                      I18n.t('models.does_not_exists',
                             subject: ''))
  end
end
