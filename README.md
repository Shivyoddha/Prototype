# IRIS Prototype - Procurement Portal

A Ruby on Rails web portal for demonstration of a procurement approval system for IRIS.

## Features

- **User Authentication**: Login system for users U, P, Q, R, S
- **Document A Workflow**: 
  - User U (Buyer) initiates document A
  - Sequential approval: U → P → Q → R → S
  - Each approver can add remarks and forward to the next stage
- **Document B Workflow**: 
  - Auto-generated after Document A approval
  - Pre-filled with data from Document A
  - Same approval flow as Document A
- **Status Tracking**: Real-time tracking of document status throughout the approval process
- **Dashboard**: Centralized view for pending approvals and document status

## Prerequisites

- Ruby 3.2.2 or higher
- PostgreSQL
- Bundler gem

## Installation

1. **Install Ruby and PostgreSQL** (if not already installed):
```bash
sudo apt-get update
sudo apt-get install -y ruby-full ruby-dev build-essential nodejs postgresql postgresql-contrib
```

2. **Install Bundler**:
```bash
gem install bundler
```

3. **Install dependencies**:
```bash
bundle install
```

4. **Set up PostgreSQL**:
```bash
sudo -u postgres psql
```

In PostgreSQL prompt:
```sql
CREATE USER iris_prototype WITH PASSWORD 'your_password';
CREATE DATABASE iris_prototype_development OWNER iris_prototype;
CREATE DATABASE iris_prototype_test OWNER iris_prototype;
\q
```

5. **Update database configuration** (if needed):
Edit `config/database.yml` with your PostgreSQL credentials.

6. **Run migrations**:
```bash
rails db:create
rails db:migrate
rails db:seed
```

7. **Start the server**:
```bash
rails server
```

8. **Access the application**:
Open your browser and go to `http://localhost:3000`

## User Accounts

Default users with passwords (can be changed via seeds):
- **U** (Buyer) - Password: U123
- **P** (Approver) - Password: P123
- **Q** (Approver) - Password: Q123
- **R** (Approver) - Password: R123
- **S** (Approver) - Password: S123

## Usage

1. **Login** as user U (Buyer)
2. **Create Document A** with equipment details
3. **Forward** document to P for approval
4. **Login** as P, Q, R, S sequentially to approve and forward
5. After S approves Document A, **Document B is auto-generated**
6. **Complete Document B** workflow with the same approval process
7. **Track status** in dashboard** at any time

## Database Schema

### Users Table
- `user_id` (string, unique)
- `user_name` (string, unique): U, P, Q, R, S
- `password_digest` (string)

### Doc_As Table
- Basic info: `eq_id`, `name`, `cost`, `head`
- User fields: `u_date`, `u_remarks`
- Approver fields: `p_date`, `p_remarks`, `q_date`, `q_remarks`, `r_date`, `r_remarks`, `s_date`, `s_remarks`
- `status` (enum): draft, pending_p_approval, pending_q_approval, pending_r_approval, pending_s_approval, approved, rejected

### Doc_Bs Table
- Auto-filled from Doc_A: `eq_id`, `name`, `cost`, `head`
- User-specific: `proceedings`
- Same approval fields as Doc_A
- Same status enum as Doc_A

## Project Structure

```
iris_prototype/
├── app/
│   ├── controllers/
│   │   ├── application_controller.rb
│   │   ├── sessions_controller.rb
│   │   ├── dashboard_controller.rb
│   │   ├── doc_as_controller.rb
│   │   └── doc_bs_controller.rb
│   ├── models/
│   │   ├── user.rb
│   │   ├── doc_a.rb
│   │   └── doc_b.rb
│   ├── views/
│   │   ├── layouts/
│   │   ├── sessions/
│   │   ├── dashboard/
│   │   ├── doc_as/
│   │   └── doc_bs/
│   └── services/
│       └── auto_create_doc_b_service.rb
├── config/
│   ├── routes.rb
│   ├── database.yml
│   └── application.rb
├── db/
│   ├── migrate/
│   └── seeds.rb
└── Gemfile
```

## License

This is a prototype demonstration project for IRIS.

