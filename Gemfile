source 'https://rubygems.org'
ruby '2.4.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.2'

group :production do
	gem 'pg'
	gem 'rails_12factor'
end

group :development do
	gem 'web-console', '>= 3.3.0'
	gem 'listen'
	gem 'sqlite3'
	gem 'mailcatcher'
end

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'bootstrap-sass'
gem 'figaro'
gem 'devise'
gem 'pundit'
gem 'stripe'

group :development, :test do
	gem 'byebug', platform: :mri
	gem 'spring'
	gem 'rspec-rails'
	gem 'rails-controller-testing'
	gem 'shoulda'
	gem 'faker'
	gem 'factory_girl_rails'
	gem 'pry-rails'
end
