# frozen_string_literal: true

class Auths::CreateSerializer < ApplicationSerializer
  attributes :access_token

  def access_token
    object[:access_token]
  end
end
