require_relative 'boot'

require "rails"
require "prawn"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Surveys
  class Application < Rails::Application
    config.i18n.default_locale = :ru

    ActionController::Renderers.add :pdf do |filename, options|
      pdf = Prawn::Document.new
      pdf.font_families.update(
	'liberation' => {
	  normal: 'app/assets/fonts/LiberationSans-Regular.ttf',
	  italic: 'app/assets/fonts/LiberationSans-Italic.ttf'
	})
      pdf.font 'liberation'
      pdf.text render_to_string(options)
      send_data(pdf.render, filename: "#{filename}.pdf", disposition: "attachment")
    end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
