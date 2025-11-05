# Email Authentication Fix Guide

## Current Status
✅ Equipment IDs are now auto-generated (no user input required)
✅ Email sending is now non-blocking (won't crash the app if email fails)

## Email Authentication Issue

The error `535-5.7.8 Username and Password not accepted` indicates that the Gmail app password is incorrect or expired.

### To Fix Email Authentication:

1. **Verify Gmail App Password:**
   - Go to: https://myaccount.google.com/apppasswords
   - Make sure 2-Step Verification is enabled on your Google account
   - Generate a new App Password for "Mail"
   - Use the 16-character password (no spaces)

2. **Update Configuration:**
   - Edit `config/environments/development.rb`
   - Update the `password` field with your new app password:
   ```ruby
   config.action_mailer.smtp_settings = {
     address: "smtp.gmail.com",
     port: 587,
     domain: "gmail.com",
     authentication: "plain",
     enable_starttls_auto: true,
     user_name: "anish.kumbhar02@gmail.com",
     password: "YOUR_NEW_16_CHAR_APP_PASSWORD"  # No spaces!
   }
   ```

3. **Restart Rails Server:**
   ```bash
   # Stop the server (Ctrl+C) and restart:
   bundle exec rails server
   ```

### Alternative: Test Without Email

The app will now work even if email fails! You can:
- Create documents successfully
- Approve/reject documents
- All workflows function normally

Email errors are logged but don't block the application.

### To Test Email After Fixing:

1. Create a new Document A as user U
2. Check the Rails logs for email delivery status
3. Check the recipient's inbox

