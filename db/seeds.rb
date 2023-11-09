# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


ActiveRecord::Base.transaction do
    1000.times do |i|
        first_name = Faker::Name.first_name
        last_name = Faker::Name.last_name
        name = "#{first_name} #{last_name}"
        user = User.create(
            first_name: first_name,
            last_name: last_name,
            username: "#{first_name.downcase}_#{i+10}",
            email: Faker::Internet.email(name: name),
            contact_number: Faker::PhoneNumber.phone_number_with_country_code,
            street_address: Faker::Address.street_address,
            city: Faker::Address.city,
            state: Faker::Address.state,
            country: Faker::Address.country,
            zipcode: Faker::Address.postcode,
            date_of_birth: (Date.today + rand(1..30).days) - rand(24..36).years,
            profile_title: User::PROFILE_TITLE.sample,
            password: 'password',
            confirmed_at: Time.now.utc,
            about: Faker::Lorem.paragraph(sentence_count: 20, supplemental: true, random_sentences_to_add: 2)
        )
    
        puts "User #{i+1}: #{name} has created succesfully." if user.persisted?
    end
end
