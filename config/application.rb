require File.expand_path '../boot', __FILE__
require 'rails/all'
Bundler.require *Rails.groups

module Jam
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # rake time:zones:all
    config.time_zone = 'Pacific Time (US & Canada)'

    # All translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += 
      Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :en
    config.active_record.raise_in_transactional_callbacks = true
  end
end
