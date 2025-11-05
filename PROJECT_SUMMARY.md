# IRIS Prototype - Project Summary

## Overview

This Ruby on Rails web portal demonstrates a procurement approval system for IRIS with a two-document workflow (Document A and Document B) involving multiple approval stages.

## System Architecture

### Users & Roles

- **U (Buyer)**: Initiates procurement documents
- **P, Q, R, S (Approvers)**: Sequential approval chain

### Workflow

#### Document A
1. **U** creates Document A with equipment details
2. **U** forwards to **P** → Date & remarks auto-captured
3. **P** approves → forwards to **Q** → Date & remarks auto-captured
4. **Q** approves → forwards to **R** → Date & remarks auto-captured
5. **R** approves → forwards to **S** → Date & remarks auto-captured
6. **S** approves → Document A complete

#### Document B (Auto-triggered)
- Automatically created when **S** approves Document A
- Pre-filled with data from Document A
- Same approval workflow as Document A

## Database Schema

### Users Table
```sql
- user_id (string, unique)
- user_name (string, unique): U, P, Q, R, S  
- password_digest (string)
```

### Doc_As Table
```sql
- eq_id (string, unique, indexed)
- name (string)
- cost (decimal)
- head (string)

- u_date, u_remarks
- p_date, p_remarks
- q_date, q_remarks
- r_date, r_remarks
- s_date, s_remarks

- status (enum)
- user_id (foreign key)
```

### Doc_Bs Table
```sql
- eq_id (string)
- name, cost, head (auto-filled from Doc_A)
- proceedings (text)

- u_date, u_remarks
- p_date, p_remarks
- q_date, q_remarks
- r_date, r_remarks
- s_date, s_remarks

- status (enum)
- user_id (foreign key)
```

## Features Implemented

✅ User authentication with bcrypt  
✅ Session management  
✅ Dashboard for each user  
✅ Document A creation workflow  
✅ Sequential approval chain (U→P→Q→R→S)  
✅ Auto-captured dates and remarks  
✅ Document B auto-generation  
✅ Status tracking  
✅ Modern, responsive UI  

## Technology Stack

- **Framework**: Ruby on Rails 7.0
- **Database**: PostgreSQL
- **Authentication**: bcrypt gem
- **Server**: Puma
- **Frontend**: ERB templates with inline CSS

## File Structure

```
/home/anish/Desktop/prototype/
├── app/
│   ├── controllers/         # Business logic
│   ├── models/              # Data models (User, DocA, DocB)
│   ├── views/               # ERB templates
│   └── services/            # Service objects
├── config/                   # Application configuration
├── db/                       # Database migrations & seeds
├── Gemfile                   # Ruby dependencies
├── README.md                 # User documentation
├── SETUP_INSTRUCTIONS.md     # Setup guide
├── PROJECT_SUMMARY.md        # This file
└── task.md                   # Requirements

```

## Status Enum Values

- `draft`: Initial state
- `pending_p_approval`: Waiting for P
- `pending_q_approval`: Waiting for Q
- `pending_r_approval`: Waiting for R
- `pending_s_approval`: Waiting for S
- `approved`: Fully approved
- `rejected`: Rejected at any stage

## Key Controllers

1. **SessionsController**: Login/logout
2. **DashboardController**: Home page with pending items
3. **DocAsController**: Document A CRUD & approval
4. **DocBsController**: Document B CRUD & approval

## Service Objects

- **AutoCreateDocBService**: Auto-generates Document B after Document A approval

## Security Features

- Password hashing with bcrypt
- Session-based authentication
- Secure password validation
- CSRF protection (Rails default)

## UI Features

- Gradient-based modern design
- Responsive layout
- Status badges with color coding
- Inline forms for approvals
- Real-time status updates
- Dashboard with pending items

## Testing Workflow

1. Run `rails db:seed` to create test users
2. Start server: `rails server`
3. Login as U → Create Document A
4. Logout → Login as P → Approve
5. Repeat for Q, R, S
6. Document B auto-generates
7. Complete Document B workflow
8. Track status in dashboard

## Deployment Ready

- Production-ready database configuration
- Environment-specific settings
- Secure password handling
- Error handling and validation

