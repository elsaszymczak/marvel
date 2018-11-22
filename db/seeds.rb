require 'json'
require 'open-uri'

puts "-----------------------------"
puts "Destroying Events"
Event.destroy_all
puts "No more Events"
puts "Destroying Characters"
Character.destroy_all
puts "No more Characters"
puts "Destroying Characters"
Comic.destroy_all
puts "No more Comics"
ComicCharacter.destroy_all
puts "No more comic characters"
puts "-----------------------------"

puts "-----------------------------"
puts "Fetching Marvel Onslaught api"
puts "-----------------------------"

event_url = 'http://gateway.marvel.com/v1/public/events/154?ts=1&apikey=36eb135a7d2a0fff3f10d2d9c735e032&hash=793e1ad819edff8e61c3680d8641f179'
event_serialized = open(event_url).read
event_hash = JSON.parse(event_serialized)
event = event_hash['data']['results'][0]

puts "-----------------------------"
puts "Getting Onslaught event"
puts "-----------------------------"

marvel_id = event['id']
title =  event['title']
event['urls'].count == 1 ? wiki_link = event['urls'][0]['url'] : wiki_link = event['urls'][1]['url']
start_date = event['start']
end_date = event['end']
event_picture = event['thumbnail']['path'] + '/standard_amazing.' + event['thumbnail']['extension']
cover_picture = event['thumbnail']['path'] + '/landscape_incredible.' + event['thumbnail']['extension']

puts "Creation of Onslaught instance"
marvel_event = Event.create(marvel_id: marvel_id, name: title, wiki_link: wiki_link, start_date: start_date, end_date: end_date, cover_picture: cover_picture)
marvel_event.remote_photo_url = event_picture
marvel_event.save

puts "-----------------------------"
puts "Retrieving the first 10 #{marvel_event.name}'s characters"
puts "-----------------------------"

characters_url = event['characters']['collectionURI']
characters_url_api = "#{characters_url}?ts=1&apikey=36eb135a7d2a0fff3f10d2d9c735e032&hash=793e1ad819edff8e61c3680d8641f179"
characters_serialized = open(characters_url_api).read
characters_hash = JSON.parse(characters_serialized)
characters = characters_hash['data']['results']

if characters.any?
  characters.first(10).each do |character|
    marvel_id = character['id']
    name = character['name']
    picture = character['thumbnail']['path'] + '/standard_fantastic.' + character['thumbnail']['extension']
    cover_picture = character['thumbnail']['path'] + '/landscape_incredible.' + character['thumbnail']['extension']

    puts "-----------------------------"
    puts "Creation of character instances"
    puts "-----------------------------"

    new_char = Character.create(marvel_id: marvel_id, name: name, event: marvel_event, cover_picture: cover_picture)
    new_char.remote_photo_url = picture
    new_char.save
  end
end

puts "-----------------------------"
puts "Retrieving marvel's event comics"
puts "-----------------------------"

comics_url = event['comics']['collectionURI']
comics_url_api = "#{comics_url}?ts=1&apikey=36eb135a7d2a0fff3f10d2d9c735e032&hash=793e1ad819edff8e61c3680d8641f179"
comics_serialized = open(comics_url_api).read
comics_hash = JSON.parse(comics_serialized)
comics = comics_hash['data']['results']
if comics.any?
  comics.first(10).each do |comic|
    marvel_id = comic['id']
    title = comic['title']
    picture = comic['thumbnail']['path'] + '/standard_fantastic.' + comic['thumbnail']['extension']
    cover_picture = comic['thumbnail']['path'] + '/landscape_incredible.' + comic['thumbnail']['extension']

    puts "-----------------------------"
    puts "Creation of comic instances"
    puts "-----------------------------"

    new_comic = Comic.create(marvel_id: marvel_id, name: title, photo: picture, event: marvel_event, cover_picture: cover_picture)
    new_comic.remote_photo_url = picture
    new_comic.save

    puts "-----------------------------"
    puts "Linking the table"
    puts "-----------------------------"

    comic['characters']["items"].each do |character|
      Character.all.each do |character_instance|
        if character["name"] == character_instance.name

          puts "-----------------------------"
          puts "Creation of comicCharacter instances"
          puts "-----------------------------"

          ComicCharacter.create(character: character_instance, comic: new_comic )
        end
      end
    end
  end
end

puts "---------------------------------"
puts "-------------DONE----------------"
puts "---------------------------------"




