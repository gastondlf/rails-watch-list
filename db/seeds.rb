# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'open-uri'
require 'json'

# 1. Clean database
puts "Cleaning database..."
List.destroy_all
Movie.destroy_all
Bookmark.destroy_all

# 2. Create the instances
api_key = "ab47a2a2393561559f9739490a8c1274"
url = "https://api.themoviedb.org/3/movie/top_rated?api_key=#{api_key}&language=en-US"
puts "Creating Movies..."

response_serialized = URI.parse(url).read
repos = JSON.parse(response_serialized)

results = repos['results']
results.each do |result|
  puts "Rating: #{result["vote_average"]}"
  movie = Movie.create!(title: result["title"], overview: result["overview"], poster_url: "https://image.tmdb.org/t/p/w500#{result["poster_path"]}", rating: result["vote_average"])
  puts "Created #{movie.title}"
end

# 3. Display result
puts "Finished! Successfully created #{Movie.count} movies"