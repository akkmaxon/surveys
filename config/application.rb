require_relative 'boot'
require_relative 'smtp_credentials'

require "rails"
require "prawn"
require "csv"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Surveys
  class Application < Rails::Application
    config.i18n.default_locale = :ru
    config.active_job.queue_adapter = :delayed_job
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: SMTP_ADDRESS,
      port: SMTP_PORT,
      user_name: SMTP_USERNAME,
      password: SMTP_PASSWORD,
      authentication: 'plain'
    }

    ActionController::Renderers.add :pdf do |filename, options|
      pdf = Prawn::Document.new
      pdf.font_families.update(
	'liberation' => {
	  normal: 'app/assets/fonts/LiberationSans-Regular.ttf',
	  italic: 'app/assets/fonts/LiberationSans-Italic.ttf'
	})
      pdf.font 'liberation'
      pdf.bounding_box([20, pdf.bounds.height], width: pdf.bounds.width - 20) do
	pdf.text render_to_string(options)
      end
      send_data(pdf.render, filename: "#{filename}.pdf", disposition: "attachment")
    end

    ActionController::Renderers.add :xls do |xls, options|
      file = StringIO.new
      xls.write file
      send_data(file.string.force_encoding('binary'), filename: "#{options[:name]}.xls", disposition: "attachment")
    end
  end
end
