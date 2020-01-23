require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module MyBlog
  class Application < Rails::Application
    config.load_defaults 6.0

    config.generators do |g|
      g.test_framework :rspec,
        fixtures: false,
                       helper_specs: false,
             routing_specs: false
    end

    config.i18n.available_locales = [:en, :ru]
    config.i18n.default_locale = :en

    config.active_job.queue_adapter = :sidekiq
  end
end
