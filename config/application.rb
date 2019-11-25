require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module IDidIt
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Disable sudo password on macos:
    # https://apple.stackexchange.com/a/333055/335512
    # basically `sudo visudo` then add the line `briankung ALL=(ALL) NOPASSWD: ALL`
    # Undo after return from China
    # config.time_zone = `sudo systemsetup -gettimezone`.chomp.split.last
    config.active_record.default_timezone = :local
    config.generators do |g|
      g.test_framework  nil, fixture: false
      g.stylesheets     false
      g.javascripts     false
      g.assets          false
      g.helper          false
    end
  end
end
