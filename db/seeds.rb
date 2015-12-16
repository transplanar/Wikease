
# Set up admin user
user = User.create!(email: "admin@example.com", password: "password")
user.update_attribute(:confirmed_at, Time.now)

user = User.create!(email: "member@example.com", password: "password")
user.update_attribute(:confirmed_at, Time.now)

20.times do
  user = User.create!(email: Faker::Internet.email, password: Faker::Internet.password)
  2.times do
    # TODO make private default to false (does it do this already?)
    user.wikis.create!(title: Faker::Lorem.sentence , body: Faker::Lorem.paragraph, private: false )
  end

  user.wikis.create!(title: Faker::Lorem.sentence , body: Faker::Lorem.paragraph, private: true )
end
