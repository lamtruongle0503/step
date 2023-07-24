# frozen_string_literal: true

class Admin::Codes::CreateSerializer < ApplicationSerializer
  attribute :code

  def code
    object[:code]
  end
end
