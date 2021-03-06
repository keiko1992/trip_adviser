Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default_url_options = {host: 'localhost', port: 3000}
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:              'smtp.gmail.com',
    port:                 587,
    authentication:       :plain,
    user_name:            ENV['DEV_GMAIL_ADDRESS'],
    password:             ENV['DEV_GMAIL_PASSWORD']
  }

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  config.after_initialize do
    Bullet.enable  = true

    Bullet.alert   = true
    Bullet.bullet_logger = false
    Bullet.console = true
    #Bullet.growl   = true   # Growl
    #Bullet.xmpp = { :account  => 'bullets_account@jabber.org',
    #                :password => 'bullets_password_for_jabber',
    #                :receiver => 'your_account@jabber.org',
    #                :show_online_status => true }
    Bullet.rails_logger = true
    #Bullet.bugsnag      = true
    #Bullet.airbrake     = true
    #Bullet.raise        = true
    Bullet.add_footer   = true

    # include paths with any of these substrings in the stack trace,
    # even if they are not in your main app
    #Bullet.stacktrace_includes = [ 'your_gem', 'your_middleware' ]
  end

  # Global defaults for Paperclip
  config.paperclip_defaults = {
    storage: :s3,
    s3_credentials: {access_key_id: Settings.aws.access_key_id, secret_access_key: Settings.aws.secret_access_key},
    url: ':s3_domain_url',
    s3_permissions: :private,
    s3_region: ENV['DEV_S3_REGION'],
    bucket: Settings.s3.public.bucket,
    path: '/:class/:attachment/:id_partition/:style/:filename',
  }
end
