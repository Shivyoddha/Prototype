# Email Configuration Debug Script
# Run this in Rails console: rails console
# Then run: load 'debug_email.rb'

puts "=" * 60
puts "Email Configuration Debug"
puts "=" * 60

puts "\n1. Checking Environment Variables:"
puts "   GMAIL_USERNAME: #{ENV['GMAIL_USERNAME'] || 'NOT SET'}"
puts "   GMAIL_PASSWORD: #{ENV['GMAIL_PASSWORD'] ? ENV['GMAIL_PASSWORD'][0..3] + '...' + ENV['GMAIL_PASSWORD'][-4..-1] : 'NOT SET'}"
puts "   Password length: #{ENV['GMAIL_PASSWORD']&.length || 0} characters"
puts "   Password has spaces: #{ENV['GMAIL_PASSWORD']&.include?(' ') ? 'YES (ERROR!)' : 'NO (OK)'}"

puts "\n2. Checking Rails Configuration:"
smtp_config = Rails.application.config.action_mailer.smtp_settings
puts "   SMTP Address: #{smtp_config[:address]}"
puts "   SMTP Port: #{smtp_config[:port]}"
puts "   SMTP Username: #{smtp_config[:user_name]}"
puts "   SMTP Password: #{smtp_config[:password] ? smtp_config[:password][0..3] + '...' + smtp_config[:password][-4..-1] : 'NOT SET'}"
puts "   SMTP Password length: #{smtp_config[:password]&.length || 0} characters"
puts "   SMTP Password has spaces: #{smtp_config[:password]&.include?(' ') ? 'YES (ERROR!)' : 'NO (OK)'}"

puts "\n3. Checking ApplicationMailer:"
puts "   From address: #{ActionMailer::Base.default[:from]}"

puts "\n4. Testing Email Connection:"
begin
  require 'net/smtp'
  
  smtp = Net::SMTP.new(smtp_config[:address], smtp_config[:port])
  smtp.enable_starttls_auto
  smtp.start(smtp_config[:domain], smtp_config[:user_name], smtp_config[:password], smtp_config[:authentication])
  puts "   ✓ SMTP connection successful!"
  smtp.finish
rescue => e
  puts "   ✗ SMTP connection failed: #{e.class} - #{e.message}"
  puts "\n   Common issues:"
  puts "   - App password incorrect or expired"
  puts "   - Password contains spaces (should be 16 characters without spaces)"
  puts "   - 2-Step Verification not enabled on Google account"
  puts "   - Less secure app access needs to be enabled (older accounts)"
end

puts "\n5. Testing Email Send:"
begin
  user_u = User.find_by(user_name: 'U')
  if user_u
    test_doc = DocA.first || DocA.create!(
      user: user_u,
      eq_id: "CSE_TEST_DEBUG",
      name: "Test Email Debug",
      cost: 100.00,
      head: "OPC",
      status: :approved
    )
    
    puts "   Attempting to send test email to #{user_u.email}..."
    ProcurementMailer.document_approved_status(test_doc, user_u, "Email Configuration Test").deliver_now
    puts "   ✓ Email sent successfully!"
  else
    puts "   ⚠ User U not found - skipping email test"
  end
rescue => e
  puts "   ✗ Email send failed: #{e.class} - #{e.message}"
  puts "   Full error: #{e.backtrace.first(3).join("\n   ")}"
end

puts "\n" + "=" * 60
puts "Debug Complete"
puts "=" * 60

puts "\nTroubleshooting Tips:"
puts "1. Get a fresh Gmail App Password from: https://myaccount.google.com/apppasswords"
puts "2. Make sure the password is 16 characters with NO spaces"
puts "3. Update config/initializers/gmail_config.rb with the new password"
puts "4. Restart the Rails server after making changes"
puts "5. Ensure 2-Step Verification is enabled on your Google account"

