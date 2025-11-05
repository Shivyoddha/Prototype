# IRIS Prototype Setup Instructions

## Quick Start

Follow these steps to get the IRIS Prototype procurement portal running on your system.

## Step 1: Install Prerequisites

### Install Ruby (3.2.2 or higher)

```bash
# Using apt (Debian/Ubuntu)
sudo apt-get update
sudo apt-get install -y ruby-full ruby-dev build-essential nodejs

# Verify installation
ruby -v
gem -v
```

### Install PostgreSQL

```bash
# Install PostgreSQL
sudo apt-get install -y postgresql postgresql-contrib

# Start PostgreSQL
sudo systemctl start postgresql
sudo systemctl enable postgresql
```

### Install Bundler

```bash
gem install bundler
```

## Step 2: Set Up Database

```bash
# Switch to postgres user
sudo -u postgres psql
```

In the PostgreSQL prompt:

```sql
CREATE USER iris_prototype WITH PASSWORD 'password123';
CREATE DATABASE iris_prototype_development OWNER iris_prototype;
CREATE DATABASE iris_prototype_test OWNER iris_prototype;
\q
```

## Step 3: Install Ruby Dependencies

```bash
# Navigate to project directory
cd /home/anish/Desktop/prototype

# Install gems
bundle install
```

## Step 4: Initialize Database

```bash
# Create databases
rails db:create

# Run migrations
rails db:migrate

# Seed with default users
rails db:seed
```

## Step 5: Start the Server

```bash
rails server
```

Or:

```bash
rails s
```

The application will be available at: `http://localhost:3000`

## Step 6: Login and Test

### Test Users

Login with these credentials:

- **U** (Buyer): Password: `U123`
- **P** (Approver): Password: `P123`
- **Q** (Approver): Password: `Q123`
- **R** (Approver): Password: `R123`
- **S** (Approver): Password: `S123`

### Workflow Testing

1. Login as **U** (Buyer)
2. Click "New Document A"
3. Fill in equipment details (Eq_ID auto-generated as CSE_1)
4. Submit → Document is forwarded to **P**
5. Logout and login as **P**
6. View pending approval in dashboard
7. Review document and add remarks
8. Click "Approve" → Document forwarded to **Q**
9. Repeat steps 5-8 for **Q**, **R**, **S**
10. After **S** approves, Document B is auto-generated
11. Complete Document B workflow

## Troubleshooting

### PostgreSQL connection error

```bash
# Ensure PostgreSQL is running
sudo systemctl status postgresql

# Check database exists
sudo -u postgres psql -l
```

### Bundle install errors

```bash
# Update RubyGems
gem update --system

# Clear bundler cache
bundle clean --force

# Reinstall
bundle install
```

### Permission errors on Unix systems

```bash
chmod +x bin/setup
chmod +x bin/rails
```

## Alternative: Using Auto Setup Script

```bash
# Make script executable
chmod +x bin/setup

# Run setup script
bin/setup
```

This script will:
- Install dependencies
- Drop and recreate database
- Run migrations
- Seed with default users

## Production Deployment

For production deployment, update `config/database.yml` and `config/environments/production.rb` with appropriate settings.

## Support

For issues or questions, refer to the README.md file.

