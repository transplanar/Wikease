
# Set up admin user
user = User.create!(email: "admin@example.com", password: "password")
# user.confirmed_at = Time.now
# REVIEW this doesn't seem to be working? Had to do this again within the rails console.
user.update_attribute(:confirmed_at, Time.now)
