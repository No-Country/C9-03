# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!
ActionMailer::Base.smtp_settings = {
    :user_name => 'apikey', # This is the string literal 'apikey', NOT the ID of your API key
    :password => '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',
    :domain => 'yendo.graciani.ar',
    :address => 'smtp.sendgrid.net',
    :port => 587,
    :authentication => :plain,
    :enable_starttls_auto => true
  }
