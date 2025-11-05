# Render Deployment Configuration

## Build Command
```bash
bundle install
bundle exec rails db:migrate
bundle exec rails db:seed
```

## Start Command
```bash
bundle exec rails server -p ${PORT:-3000}
```

## Environment Variables Needed
- `DATABASE_URL` - PostgreSQL connection string (provided by Render)
- `RAILS_ENV` - Set to `production`

## Database Setup
The app uses PostgreSQL. Make sure to:
1. Create a PostgreSQL database in Render
2. The `DATABASE_URL` will be automatically set by Render
3. Run migrations: `bundle exec rails db:migrate`
4. Seed initial data: `bundle exec rails db:seed`

## Email Configuration for Production
Update `config/environments/production.rb` with your SMTP settings:
```ruby
config.action_mailer.smtp_settings = {
  address: "smtp.gmail.com",
  port: 587,
  domain: "gmail.com",
  authentication: "plain",
  enable_starttls_auto: true,
  user_name: ENV['GMAIL_USERNAME'],
  password: ENV['GMAIL_PASSWORD']
}
```

Set these as environment variables in Render:
- `GMAIL_USERNAME`
- `GMAIL_PASSWORD`

## Local Development
To run locally:
```bash
rails s
# or
bundle exec rails s
```

Both commands work the same way.

