Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local = true
  config.server_timing = true
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.active_record.verbose_query_logs = true
  
  # Active Storage configuration
  config.active_storage.service = :local
  
  # Mailer configuration
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.default_url_options = { host: ENV['APP_HOST'] || '68.183.92.190', protocol: ENV['APP_PROTOCOL'] || 'http' }
  
  # Use environment variables for credentials
  config.action_mailer.smtp_settings = {
    address:              "smtp.gmail.com",
    port:                 587,
    domain:               "gmail.com",
    user_name:            ENV['GMAIL_USERNAME'] || 'anish.kumbhar02@gmail.com',
    password:             ENV['GMAIL_PASSWORD'] || 'opqcjobzezaevrsk',
    authentication:       "plain",
    enable_starttls_auto: true
  }
end
