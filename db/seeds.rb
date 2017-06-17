# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

3.times do
	user = User.create!(
		email:    Faker::Internet.unique.email,
		password: Faker::Internet.password
	)
	user.skip_confirmation!
	user.save!
end
standard_seed_user = User.where(role: "standard")

3.times do
	user = User.create!(
		email:    Faker::Internet.unique.email,
		password: Faker::Internet.password
	)
	user.skip_confirmation!
	user.premium!
	user.save!
end
premium_seed_user = User.where(role: "premium")

5.times do
	wiki = Wiki.create!(
		title:   Faker::Beer.unique.name,
		body:    Faker::Lorem.paragraphs(10),
		private: false,
		user:    standard_seed_user.sample
	)
	wiki.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
end
public_wiki = Wiki.where(private: false)

5.times do
	wiki = Wiki.create!(
		title:   Faker::Beer.unique.name,
		body:    Faker::Lorem.paragraphs(10),
		private: true,
		user:    premium_seed_user.sample
	)
	wiki.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
end
private_wiki = Wiki.where(private: true)

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
puts "#{standard_seed_user.count} standard users created"
puts "#{premium_seed_user.count} premium users created"
puts "#{public_wiki.count} public wikis created"
puts "#{private_wiki.count} private wikis created"
