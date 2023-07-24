# frozen_string_literal: true

namespace :db do
  task get_all_permissions: :environment do
    require Rails.root.join('config', 'routes.rb')
    ActiveRecord::Base.transaction do
      @new_permissions = []
      permissions = Rails.application.routes.set.each_with_object([]) do |route, arr|
        next arr if unauthorize_route?(route)

        arr << custom_permission(route)
      end

      write_new_permissions!(permissions)
      destroy_unuse_permissions!
    end
  end

  private

  def custom_permission(route)
    if route.defaults[:permission].is_a?(String)
      route.defaults[:permission].split('/')
    else
      action = load_action(route)
      route.defaults[:permission][action].split('/')
    end
  end

  def write_new_permissions!(permissions)
    permissions.each { |permission| write_permission!(permission) }
  end

  def write_permission!(permission)
    action      = permission.first
    module_name = permission.second

    @new_permissions << Permission.find_or_create_by!(action: action, module_name: module_name)
  end

  def destroy_unuse_permissions!
    unuse_permissions = Permission.where.not(id: @new_permissions.pluck(:id))
    unuse_permissions.each(&:really_destroy!)
  end

  def unauthorize_route?(route)
    return true if !route.defaults[:permission] || unuse_controllers?(route)

    if route.defaults[:permission].is_a?(Hash)
      action = load_action(route)
      return !route.defaults[:permission][action]
    end
    false
  end

  def unuse_controllers?(route)
    unuse_controllers = ['rails/info', 'rails/welcome', 'rails/mailers', nil]
    unuse_controllers.include?(route.defaults[:controller])
  end

  def load_action(route)
    route.defaults.present? ? route.defaults[:action].to_sym : ''
  end
end
