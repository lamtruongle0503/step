# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :actor, :record, :params

  include ApplicationHelper

  def initialize(actor, record, options = {})
    @actor  = actor
    @record = record
    @params = options[:params]
  end

  def index?
    return true if actor.is_a? Admin

    user_permissions = permissions('read')
    user_permissions.present?
  end

  def show?
    return true if actor.is_a? Admin

    user_permissions = permissions('read')
    user_permissions.present?
  end

  def create?
    return true if actor.is_a? Admin

    user_permissions = permissions('write')
    user_permissions.present?
  end

  def new?
    return true if actor.is_a? Admin

    create?
  end

  def update?
    return true if actor.is_a? Admin

    user_permissions = permissions('write')
    user_permissions.present?
  end

  def edit?
    return true if actor.is_a? Admin

    update?
  end

  def destroy?
    return true if actor.is_a? Admin

    user_permissions = permissions('write')
    user_permissions.present?
  end

  def scope
    Pundit.policy_scope!(actor, record.class)
  end

  def permissions(action, module_name = nil)
    module_name ||= self.module_name
    actor.company_department.permissions.select do |permission|
      permission[:action] == action && permission[:module_name] == module_name
    end
  end

  def access?(permissions)
    permissions.present?
  end

  def module_name
    self.class.to_s.sub('Policy', '').parameterize.underscore.singularize
  end

  class Scope
    attr_reader :actor, :scope

    def initialize(actor, scope)
      @actor = actor
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
