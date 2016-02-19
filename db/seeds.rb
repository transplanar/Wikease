user = User.create!(email: "admin@example.com", password: "password", confirmed_at: Time.now, role: 'admin')

user = User.create!(email: "member@example.com", password: "password", confirmed_at: Time.now)

user = User.create!(email: "member2@example.com", password: "password", confirmed_at: Time.now)

20.times do
  user = User.new(email: Faker::Internet.email, password: Faker::Internet.password)
  user.skip_confirmation!
  user.save!
end

User.all.each do |user|
  6.times do
    user.wikis.create!(title: Faker::Lorem.sentence , body: Faker::Lorem.paragraph)
  end
end

User.last(5).each do |user|
  user.premium!
  user.wikis.create!(title: "PRIVATE #{Faker::Lorem.sentence}" , body: Faker::Lorem.paragraph, private: true )
end
