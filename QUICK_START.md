# Quick Start Guide

## Running the Server

### Standard Rails Command
```bash
rails s
```

### Or with bundle exec (recommended)
```bash
bundle exec rails s
```

Both commands start the server on `http://localhost:3000`

## Equipment ID Generation Fixed

✅ Equipment IDs are now auto-generated correctly
✅ Handles edge cases (non-standard IDs like "pii" are ignored)
✅ Always generates the next sequential ID (CSE_1, CSE_2, CSE_3, etc.)

## For Render Deployment

The `Procfile` is already configured. Render will automatically:
1. Run `bundle install`
2. Run migrations
3. Start the server using the Procfile

### Environment Variables to Set in Render:
- `GMAIL_USERNAME` - Your Gmail address
- `GMAIL_PASSWORD` - Your Gmail app password
- `APP_HOST` - Your Render app URL (optional, defaults to localhost)
- `RAILS_ENV` - Set to `production` (usually auto-set by Render)

### Database Setup:
1. Create a PostgreSQL database in Render
2. The `DATABASE_URL` will be automatically provided
3. Run migrations: `bundle exec rails db:migrate`
4. Seed data: `bundle exec rails db:seed`

## Testing Equipment ID Generation

Try creating a new Document A - it should automatically assign the next available ID without any conflicts!

