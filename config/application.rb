require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TrustBin
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.to_prepare do
      # Configure single controller layout
      Devise::SessionsController.layout "session"
    end

    # store key reference in message
    config.active_record.encryption.store_key_references = true

    # We allow unencrypted data so the demo seed works
    config.active_record.encryption.support_unencrypted_data = true

    config.active_record.encryption.key_derivation_salt = ENV['RAILS_SALT'] || "salt"
    config.active_record.encryption.deterministic_key = ENV['RAILS_DETERMINISTIC_KEY'] || "deterministic-key"
    config.active_record.encryption.primary_key = ENV['RAILS_PRIMARY_KEY'] || "primary-key"

  end
end
