# Email Notification Features

## Overview
The IRIS Procurement Portal now includes comprehensive email notifications for all document status changes.

## Email Configuration

### Gmail Settings
- **Sender Email**: anish.kumbhar02@gmail.com
- **App Password**: tdum hmfl dwrk gtqu
- **SMTP Server**: smtp.gmail.com:587
- **Application Name**: ProcurementModule

### Email Recipients
- **User U (Buyer)**: anish.kumbhar02@gmail.com
- **Approvers P, Q, R, S**: brc@nitk.edu.in

## Email Notifications Sent

### For Approvers (P, Q, R, S)
1. **New Document Submission**: Notified when a new document requires their approval
   - Includes document details (Equipment ID, Name, Cost, Head)
   - Shows who created the document
   - Contains link to access the portal

### For Buyer (User U)
1. **Document Approved**: Notified when document is approved and moves to next stage
   - Shows which approver approved
   - Shows current status
   - Indicates who is reviewing next

2. **Document Fully Approved**: Notified when Document A or B is fully approved
   - Final approval notification
   - Completion status

3. **Document Rejected**: Notified when document is rejected
   - Shows rejection reason
   - Includes approver's remarks
   - Requires action from buyer

## Email Workflow

### Document A Flow
1. U creates Document A → Email to P
2. P approves → Emails to U and Q
3. Q approves → Emails to U and R
4. R approves → Emails to U and S
5. S approves → Email to U (complete)
   - Auto-creates Document B

### Document B Flow
1. U creates Document B → Email to P
2. P approves → Emails to U and Q
3. Q approves → Emails to U and R
4. R approves → Emails to U and S
5. S approves → Email to U (complete)

### Rejection Flow
- Any approver rejects → Email to U with rejection reason

## Email Templates

### Location
- HTML Templates: `app/views/procurement_mailer/`
- Text Templates: `app/views/procurement_mailer/` (with `.text.erb` extension)
- Layout: `app/views/layouts/mailer.html.erb`

### Email Content Includes
- Header with IRIS branding
- Document details (Equipment ID, Name, Cost)
- Status information
- Action buttons/links
- Footer with copyright information

## Testing

To test email notifications:
1. Create a Document A as user U
2. Check email for brc@nitk.edu.in (approver notification)
3. Login as P and approve
4. Check email for anish.kumbhar02@gmail.com (status update)
5. Check email for brc@nitk.edu.in (next approver notification)

## Configuration Files

- `config/environments/development.rb` - SMTP settings
- `config/initializers/gmail_config.rb` - Gmail credentials
- `app/mailers/procurement_mailer.rb` - Email logic
- `app/controllers/doc_as_controller.rb` - Triggers for Doc A
- `app/controllers/doc_bs_controller.rb` - Triggers for Doc B

## Production Deployment

For production, update:
- `config/environments/production.rb` - Use production SMTP settings
- Environment variables for sensitive credentials
- Update default_url_options to production domain

