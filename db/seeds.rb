# Update or create admin user
admin = User.find_or_initialize_by(user_name: 'admin')
admin.assign_attributes(
  user_id: 'admin',
  email: 'admin@gmail.com',
  display_name: 'Administrator',
  password: '123456',
  password_confirmation: '123456',
  is_admin: true
)
admin.save!

# Update or create default users with emails
['U', 'P', 'Q', 'R', 'S'].each do |name|
  user = User.find_or_initialize_by(user_name: name)
  user.assign_attributes(
    user_id: name.downcase,
    email: name == 'U' ? 'anish.kumbhar04@gmail.com' : 'brc@nitk.edu.in',
    display_name: name == 'U' ? 'Buyer' : "Approver #{name}",
    password: name + '123',
    password_confirmation: name + '123'
  )
  user.save!
end

puts "Admin user: admin@gmail.com (Password: 123456)"
puts "User U email: anish.kumbhar04@gmail.com"
puts "Approvers (P, Q, R, S) email: brc@nitk.edu.in"
puts "Users updated successfully!"

