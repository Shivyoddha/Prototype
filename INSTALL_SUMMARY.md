# IRIS Prototype - Installation Complete!

## ✅ Project Created Successfully

Your Ruby on Rails procurement portal for IRIS has been fully set up. The complete application is ready to run!

## 📁 Project Location

```
/home/anish/Desktop/prototype/
```

## 🚀 Quick Start

### 1. Install Ruby and Dependencies

If you don't have Ruby 3.2.2+ and PostgreSQL installed:

```bash
# Install Ruby and PostgreSQL
sudo apt-get update
sudo apt-get install -y ruby-full ruby-dev build-essential nodejs postgresql postgresql-contrib

# Install Bundler
gem install bundler
```

### 2. Set Up PostgreSQL Database

```bash
# Create database user
sudo -u postgres psql
```

In PostgreSQL:
```sql
CREATE USER iris_prototype WITH PASSWORD 'password123';
CREATE DATABASE iris_prototype_development OWNER iris_prototype;
CREATE DATABASE iris_prototype_test OWNER iris_prototype;
\q
```

### 3. Install and Configure

```bash
# Navigate to project
cd /home/anish/Desktop/prototype

# Install gems
bundle install

# Setup database
rails db:create
rails db:migrate
rails db:seed
```

### 4. Start the Application

```bash
rails server
```

Visit: `http://localhost:3000`

## 👥 Test User Credentials

- **U** (Buyer) - Password: `U123`
- **P** (Approver) - Password: `P123`
- **Q** (Approver) - Password: `Q123`
- **R** (Approver) - Password: `R123`
- **S** (Approver) - Password: `S123`

## 🔄 Testing the Workflow

1. Login as **U** → Create "Document A"
2. Logout → Login as **P** → Approve & forward
3. Logout → Login as **Q** → Approve & forward
4. Logout → Login as **R** → Approve & forward
5. Logout → Login as **S** → Approve
6. **Document B** auto-generates
7. Complete Document B approval chain

## 📋 What's Included

### Models
- ✅ User (authentication)
- ✅ DocA (Document A with approval workflow)
- ✅ DocB (Document B auto-generated after DocA)

### Controllers
- ✅ SessionsController (login/logout)
- ✅ DashboardController (home page)
- ✅ DocAsController (Document A management)
- ✅ DocBsController (Document B management)

### Views
- ✅ Modern responsive UI with gradient design
- ✅ Login page
- ✅ Dashboard with pending approvals
- ✅ Document creation forms
- ✅ Document approval/rejection interface
- ✅ Status tracking display

### Features
- ✅ Sequential approval workflow (U→P→Q→R→S)
- ✅ Auto-captured dates and remarks
- ✅ Status tracking throughout
- ✅ Document B auto-generation
- ✅ Session-based authentication
- ✅ Secure password hashing

## 📚 Documentation Files

- `README.md` - Comprehensive user guide
- `SETUP_INSTRUCTIONS.md` - Detailed setup guide
- `PROJECT_SUMMARY.md` - Technical summary
- `INSTALL_SUMMARY.md` - This file
- `task.md` - Original requirements

## 🛠️ Available Commands

```bash
rails server          # Start development server
rails console         # Open Rails console
rails db:migrate      # Run pending migrations
rails db:seed         # Seed database with users
rails routes           # View all routes
```

## 🎨 UI Features

- Modern gradient design
- Responsive layout
- Status badges with color coding
- Real-time dashboard updates
- Inline approval/rejection forms
- Clean, professional appearance

## ⚙️ Configuration

The application uses:
- **Database**: PostgreSQL
- **Authentication**: bcrypt
- **Server**: Puma
- **Template Engine**: ERB

All configuration files are in `/config/` directory.

## 🎯 Next Steps

1. Follow installation steps above
2. Start the server
3. Test the complete workflow
4. Customize as needed for your IRIS requirements

## 🆘 Troubleshooting

**PostgreSQL connection error?**
```bash
sudo systemctl status postgresql
sudo -u postgres psql -l
```

**Gems won't install?**
```bash
gem update --system
bundle clean --force
bundle install
```

**Migration errors?**
```bash
rails db:drop db:create db:migrate db:seed
```

## ✨ Enjoy Your IRIS Prototype!

The procurement portal is ready for demonstration. Follow the workflow to test all approval stages and document processing.

