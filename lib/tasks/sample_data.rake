namespace :db do	
	desc "Fill database with sample data"
	task populate: :environment do
		User.create!(name: "thomas", 
					email: "thomas@email.com",
					password: "password",
					password_confirmation: "password",
					admin: true)
		User.create!(name: "whatever User",
					email: "whatever@newexample.org",
					password: "foobar",
					password_confirmation: "foobar")
		99.times do |n|
			name = Faker::Name.name
			email = "example-#{n+1}@example.org"
			password = "password"
			User.create!(name: name,
						email: email,
						password: password,
						password_confirmation: password)
		end
		user = User.create!(name: "admin",
			email: "admin@email.com",
			password: "password",
			password_confirmation: "password",
			admin: true)
		50.times do
			content = Faker::Lorem.sentence(5)
			title = Faker::Lorem.sentence(1)
			user.posts.create!(title: title, content: content)
		end

	end
end