require 'faker'
require 'rest-client'

# This is where you can create initial data for your app.
# game = Game.new
# game.title = 'Mario Brothers'
# game.publishing_date = '1982-03-04'
# game.genre = 'Platforms'
# game.save # returns true / false
# game.save! # crashes the app if save is not successful

puts "Erasing all the games..."
Game.destroy_all

puts "Creating 100 test games..."
100.times do
  # game = Game.new
  # game.name = 'Mario Brothers'
  # game.publishing_date = '1982-03-04'
  # game.genre = 'Platforms'

  # game = Game.new(
  #   name: 'Mario Brothers',
  #   publishing_date: '1982-03-04',
  #   genre: 'Platforms'
  # )
  # game.save! # save! should be used in the seeds AND ONLY IN THE SEEDS!

  # Game.create is exactly like a .new .save
  Game.create!(
    name: Faker::Game.title,
    publishing_date: Faker::Date.between(from: '1980-01-01', to: '2023-01-01'),
    genre: Faker::Game.genre,
    score: Faker::Number.between(from: 1, to: 10)
  )
  # create! should be used in the seeds AND ONLY IN THE SEEDS!
end
puts "DONE! 🎉"


response_string = RestClient.get('https://hacker-news.firebaseio.com/v0/topstories.json')
# response_string is always a STRING of text
ids = JSON.parse(response_string) # will convert the string into actual ruby objects

ids.first(10).each do |id|
  response_string = RestClient.get("https://hacker-news.firebaseio.com/v0/item/#{id}.json")
  info = JSON.parse(response_string, symbolize_names: true)

  Post.create!(title: info[:title], url: info[:url])
end
