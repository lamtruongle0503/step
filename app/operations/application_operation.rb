# frozen_string_literal: true

class ApplicationOperation
  include ApplicationHelper
  include Pundit::Authorization

  attr_accessor :params, :actor

  def initialize(actor, params)
    @params = params
    @actor  = actor
  end

  def call; end

  def authorize(record, policy_class = nil, query = nil)
    query ||= "#{params[:action]}?"

    @_pundit_policy_authorized = true

    policy = if policy_class
               policy_class&.new(actor, record, params: params)
             else
               Pundit.policy!(actor, record)
             end

    unless policy.public_send(query)
      raise Pundit::NotAuthorizedError, query: query, record: record,
policy: policy
    end

    record
  end
end
