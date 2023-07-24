# frozen_string_literal: true

class Api::Notifications::Counts::IndexSerializer < ApplicationSerializer
  attribute :unread_number

  def unread_number
    object[:unread_number]
  end
end
