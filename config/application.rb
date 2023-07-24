require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TemplateRailsReact
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :utc

    config.autoload_paths << Rails.root.join("app", "validators")
    config.autoload_paths << Rails.root.join("app", "operations")
    config.autoload_paths << Rails.root.join("app", "contracts")
    # config.autoload_paths << Rails.root.join("app", "operations", "api", "concerns")
    # config.autoload_paths << Rails.root.join("app", "operations", "admin", "concerns")
    config.autoload_paths << Rails.root.join("app", "services")

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]

    # Load all routes
    config.autoload_paths += %W(#{config.root}/config/routes)
    config.i18n.available_locales = [:en]
    config.i18n.default_locale = :en
  end
end
