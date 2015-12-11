
# Set up admin user
user = User.create!(email: "admin@example.com", password: "password")
user.confirmed_at = Time.now
