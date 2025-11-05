# Email Testing Script
# Run this in Rails console: rails console
# Then run: load 'test_email.rb'

puts "Testing email functionality..."

# Test email to User U
user_u = User.find_by(user_name: 'U')
if user_u
  puts "Found User U with email: #{user_u.email}"
  
  # Create a test document
  test_doc = DocA.first || DocA.create!(
    user: user_u,
    eq_id: "CSE_TEST",
    name: "Test Equipment",
    cost: 100.00,
    head: "OPC",
    status: :approved
  )
  
  puts "Sending test email to #{user_u.email}..."
  begin
    ProcurementMailer.document_approved_status(test_doc, user_u, "Test Email - System Check").deliver_now
    puts "✓ Email sent successfully to #{user_u.email}!"
  rescue => e
    puts "✗ Error sending email: #{e.message}"
  end
else
  puts "User U not found"
end

# Test email to Approver P
approver_p = User.find_by(user_name: 'P')
if approver_p
  puts "\nFound Approver P with email: #{approver_p.email}"
  
  test_doc = DocA.first || DocA.create!(
    user: user_u,
    eq_id: "CSE_TEST2",
    name: "Test Equipment 2",
    cost: 200.00,
    head: "IRG",
    status: :pending_p_approval
  )
  
  puts "Sending test email to #{approver_p.email}..."
  begin
    ProcurementMailer.document_submitted_to_approver(test_doc, 'P').deliver_now
    puts "✓ Email sent successfully to #{approver_p.email}!"
  rescue => e
    puts "✗ Error sending email: #{e.message}"
  end
else
  puts "Approver P not found"
end

puts "\nEmail test completed. Check your inbox!"

