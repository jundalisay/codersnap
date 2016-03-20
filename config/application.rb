require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  Bundler.require(*Rails.groups(:assets => %w(development test)))
end

module Snap2
  class Application < Rails::Application

    config.active_support.escape_html_entities_in_json = true

    config.assets.enabled = true

    config.assets.version = '1.0'

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: "smtp.gmail.com",
      port: 587,
      domain: "codersnap.herokuapp.com",
      user_name: 'narahelpdesk',
      password: 'nara1234',
      authentication: "plain",
      enable_starttls_auto: true
    }

    config.active_record.raise_in_transactional_callbacks = true
    WillPaginate.per_page = 5
  end
end