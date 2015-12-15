
# Set up admin user
user = User.create!(email: "admin@example.com", password: "password")
# user.confirmed_at = Time.now
# REVIEW this doesn't seem to be working? Had to do this again within the rails console.
user.update_attribute(:confirmed_at, Time.now)


20.times do
  user = User.create!(email: Faker::Internet.email, password: Faker::Internet.password)
  2.times do
    # TODO make private default to false (does it do this already?)
    user.wikis.create!(title: , body: , private: false )
  end

  # create one private wiki
  user.wikis.create
end
