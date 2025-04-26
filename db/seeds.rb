# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Set post title to the current date
current_date = Time.now.strftime("%B %d, %Y") # e.g., "April 18, 2025"

# Create a new post and add teams from CSV
post = Post.create(title: current_date)

days = []
doc = Nokogiri::HTML(URI.open('https://weather.com/weather/tenday/l/24df4c723985151b20d748e923d6ebf7d1ca87ea7e0a457693374495882ecfed'))
doc.css('.DetailsSummary--daypartName--CcVUz').each do |data|
	days.push(data.content.strip)
end
days.shift

hitemps = []
doc.css('.DetailsSummary--highTempValue--VHKaO').each do |data|
	hitemps.push(data.content.strip)
end
hitemps.shift

lowtemps = []
doc.css('.DetailsSummary--lowTempValue--ogrzb').each do |data|
	lowtemps.push(data.content.strip)
end
lowtemps.shift

f = []
days.each_with_index do |day, index|
	f.push("#{days[index]}: #{hitemps[index]} #{lowtemps[index]}")
end


days.each_with_index do |day, index|
	post.daycasts.create(
		cast: "#{days[index]}: #{hitemps[index]} #{lowtemps[index]}")
	puts "cast added to post"
end