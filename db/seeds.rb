# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do
	user = User.create!(
		email:    Faker::Internet.unique.email,
		password: Faker::Internet.password
	)
	user.skip_confirmation!
	user.save!
end
users = User.all

20.times do
	wiki = Wiki.create!(
		title:   Faker::Beer.unique.name,
		body:    Faker::Lorem.paragraphs(10),
		private: false,
		user:    users.sample
	)
	wiki.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
end
wikis = Wiki.all

standard_user = User.create!(
	email:    "member@blocipedia7022.com",
	password: "password"
)
standard_user.skip_confirmation!
standard_user.save!

premium_user = User.create!(
	email:    "premium@blocipedia7022.com",
	password: "password",
	role:     "premium"
)
premium_user.skip_confirmation!
premium_user.save!

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
