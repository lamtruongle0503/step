# frozen_string_literal: true

class Admin::Users::ShowSerializer < Admin::Users::AttributesSerializer
  attributes %i[first_name last_name first_name_kana last_name_kana]
end
