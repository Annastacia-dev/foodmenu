require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Foodmenu
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks))

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    # Sidekiq
    Sidekiq.configure_client do |config|
      config.redis = { url: ENV['REDISCLOUD_URL'] }
    end

    Sidekiq.configure_server do |config|
      config.redis = { url: ENV['REDISCLOUD_URL'] }
    end

    # mailing
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.postmark_settings = { api_token: Rails.application.credentials.postmark[:api_token] }

    config.action_mailer.smtp_settings = {
      user_name: Rails.application.credentials.mail[:user_name],
      password: Rails.application.credentials.mail[:password],
      domain: Rails.application.credentials.mail[:domain],
      address: Rails.application.credentials.mail[:address],
      port: Rails.application.credentials.mail[:port],
      authentication: Rails.application.credentials.mail[:authentication],
      enable_starttls: Rails.application.credentials.mail[:enable_starttls],
      openssl_verify_mode: Rails.application.credentials.mail[:openssl_verify_mode],
      open_timeout: 5,
      read_timeout: 5
    }

  end
end
