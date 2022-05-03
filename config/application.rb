require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    config.load_defaults 6.1
    config.i18n.available_locales = %i[ja en]
    config.i18n.enforce_available_locales = true
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.time_zone = 'Tokyo'

    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: true,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false
    end
  end
end
