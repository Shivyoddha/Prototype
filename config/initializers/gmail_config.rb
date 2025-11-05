# Gmail Configuration
# Set Gmail credentials if not already set
# IMPORTANT: Gmail App Passwords are 16 characters WITHOUT spaces
# Remove all spaces from your app password before pasting here

ENV['GMAIL_USERNAME'] ||= 'anish.kumbhar02@gmail.com'
ENV['GMAIL_PASSWORD'] ||= 'tdumhmfldwrkgtqu'  # Make sure this is your actual app password WITHOUT spaces
ENV['APP_NAME'] ||= 'ProcurementModule'

# Also set directly for immediate use
Rails.application.config.gmail_username = ENV['GMAIL_USERNAME']
Rails.application.config.gmail_password = ENV['GMAIL_PASSWORD']

