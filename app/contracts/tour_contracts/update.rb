# frozen_string_literal: true

class TourContracts::Update < TourContracts::Base
  attribute :record, Tour

  validates :code, presence: true
  validate :valid_code

  def valid_code
    return if record.code == code

    errors.add(:code, I18n.t('models.exists'))
  end
end
