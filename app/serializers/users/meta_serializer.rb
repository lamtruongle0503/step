# frozen_string_literal: true

class Users::MetaSerializer < ApplicationSerializer
  attributes %i[id first_name last_name first_name_kana last_name_kana full_name furigana]
end
