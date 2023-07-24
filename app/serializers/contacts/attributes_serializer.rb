# frozen_string_literal: true

class Contacts::AttributesSerializer < ApplicationSerializer
  attributes :id, :code, :phone_number, :email, :contents, :user, :furigana, :todo
end
