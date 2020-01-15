require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MyBlog
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.generators do |g|
      g.test_framework :rspec,
        fixtures: false,
                       helper_specs: false,
             routing_specs: false
    end

    config.i18n.available_locales = [:en, :ru]
    config.i18n.default_locale = :en

    # Warden

    Warden::Manager.serialize_into_session do |user|
      user.id
    end

    Warden::Manager.serialize_from_session do |id|
      User.find_by_id(id)
    end

    Rails.application.config.middleware.use Warden::Manager do |manager|
      manager.default_strategies :password
      manager.failure_app = UnauthorizedController
    end
  end
end
