# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Genre, seeding ..."
genres = Genre.create([
                {title: "Comedies", slug: "comedies"}, 
                {title: "Violent", slug: "violent"}, 
                {title: "Thriller", slug: "thriller"}, 
                {title: "Sci-Fi", slug: "sci-fi"},
                {title: "Action", slug: "action"},
                {title: "Drama", slug: "drama"},
            ])
puts "Genre, seed done."

puts "Cast, seeding ..."
casts = Cast.create!([
                        {first_name: "Johnny", middle_name: "Sen", last_name: "Wuyu", stage_name: "Randel"}, 
                        {first_name: "Omen", middle_name: "Sie", last_name: "Honyo", stage_name: "Watta"},
                        {first_name: "Erlik", middle_name: "Back", last_name: "Man", stage_name: "Erlim"},
                        {first_name: "Henston", middle_name: "Sue", last_name: "Del mont", stage_name: "Russ"},
                        {first_name: "Shen", middle_name: "Ui", last_name: "Dem", stage_name: "Entor"},
                        {first_name: "Harr", middle_name: "Man", last_name: "mont", stage_name: "Jinyang"},
                    ])

casts.each_with_index do |cast, index|
    cast.image.attach(io: File.open("#{Rails.root}/app/assets/images/casts/seed_image_#{index}.jpeg"), filename: "seed_image_#{index}.jpeg")
end
puts "Cast, seed done."

puts "Movie, seeding ..."
movies = Movie.create!([
                {title: "Movie One", slug: "movie-one",release_year: "2020"},
                {title: "Movie Two", slug: "movie-two",release_year: "2019"},
                {title: "Movie Three", slug: "movie-three",release_year: "2020"},
                {title: "Movie Four", slug: "movie-four",release_year: "2021"},
                {title: "Movie Five", slug: "movie-five",release_year: "2022"},
                {title: "Movie Six", slug: "movie-six",release_year: "2018"},
            ])

movies.each_with_index do |movie, index|
    movie.image.attach(io: File.open("#{Rails.root}/app/assets/images/movies/seed_movie_image_#{index}.jpeg"), filename: "seed_movie_image_#{index}.jpeg")

    movie.casts << casts[index] if casts[index].present?

    movie.genres << genres[index] if genres[index].present?
end
puts "Movie, seed done."




