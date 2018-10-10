# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


20.times do
  Author.create(
    name: Faker::LordOfTheRings.character,
    image: Faker::Fillmurray.Image
  )
end

 30.times do
  book = Book.create(
    title: Faker::Book.title,
    pages: Faker::Number.number(3),
    year: Faker::Number.within(1940..2010),
    image: Faker::LoremPixel.image
  )

    rand(1..2).times do
      book.book_author.create(
        author_id: rand(1..20)
      )
    end
end

20.times do
  user = User.create(
    name: Faker::GameOfThrones.character,
    image: Faker::Avatar.image
  )

  rand(1..5).times do
    user.review.create(
      title: Faker::MichaelScott.quote,
      description: Faker::SiliconValley.quote,
      score: Faker::Number.within(1..5),
      book_id: rand(1..30)
   )
  end
end


 #  20.times do
 #    author.book_author.create(
 #     book_id: rand(1..30)
 #   )
 # end
