# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

['standard', 'premium', 'admin'].each do |role|
  Role.find_or_create_by({name: role})
end

user_one = User.create!(
	email: "member@blocipedia7022.com",
	password: "password",
	confirmed_at: Time.now
)

user_two = User.create!(
	email: "other_member@blocipedia7022.com",
	password: "password",
	confirmed_at: Time.now
)
