# Load the Rails application.
require_relative 'application'
ActionMailer::Base.smtp_settings = {
    :user_name => 'forum@raven.web.tr',
    :password => '7986GTez-',
    :address => 'mail.yoncu.com',
    :port => 587,
    :authentication => :ssl,
    :enable_starttls_auto => true
}
# Initialize the Rails application.
Rails.application.initialize!
