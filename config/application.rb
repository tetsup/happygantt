require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    config.load_defaults 6.1
    config.i18n.available_locales = %i[ja en]
    config.i18n.enforce_available_locales = true
    config.i18n.default_locale = :ja
    config.time_zone = 'Tokyo'
  end
end
