# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


30.times do
  Book.create(
 title: Faker::Book.title,
 pages: Faker::Number.number(3),
 year: Faker::Number.within(1940..2010),
 image: Faker::LoremPixel.image
)
end

10.times do
  User.create(
    name: Faker::GameOfThrones.character,
    image: Faker::Avatar.image
  )
end

 10.times do
   Review.create(
     title: Faker::MichaelScott.quote,
     description: Faker::SiliconValley.quote,
     score: Faker::Number.within(1..5)
   )
  end

  10.times do
    Author.create(
      name: Faker::LordOfTheRings.character,
      image: Faker::Fillmurray.Image
    )
  end
