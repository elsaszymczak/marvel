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

puts "Creation of event instance"
marvel_event = Event.create(marvel_id: marvel_id, name: title, wiki_link: wiki_link, start_date: start_date, end_date: end_date, picture: event_picture, cover_picture: cover_picture)

puts "-----------------------------"

puts "Retrieving the first 10 #{marvel_event.name}'s characters"

puts "-----------------------------"

characters_url = event['characters']['collectionURI']
characters_url_api = "#{characters_url}?ts=1&apikey=36eb135a7d2a0fff3f10d2d9c735e032&hash=793e1ad819edff8e61c3680d8641f179"
characters_serialized = open(characters_url_api).read
characters_hash = JSON.parse(characters_serialized)
characters = characters_hash['data']['results']

if !characters.empty?
  characters.first(10).each do |character|
    marvel_id = character['id']
    name = character['name']
    picture = character['thumbnail']['path'] + '/standard_fantastic.' + character['thumbnail']['extension']
    cover_picture = character['thumbnail']['path'] + '/landscape_incredible.' + character['thumbnail']['extension']


    puts "Creation of character instances"
    new_character = Character.create(marvel_id: marvel_id, name: name, picture: picture, event: marvel_event, cover_picture: cover_picture)

    puts "-----------------------------"
    puts "Retrieving the first 5 #{new_character.name}'s comics"
    puts "-----------------------------"




    # character_comics_url = character['comics']['collectionURI']
    # character_comics_url_api = "#{character_comics_url}?ts=1&apikey=36eb135a7d2a0fff3f10d2d9c735e032&hash=793e1ad819edff8e61c3680d8641f179"
    # character_comics_serialized = open(character_comics_url_api).read
    # character_comics_hash = JSON.parse(character_comics_serialized)
    # character_comics = character_comics_hash['data']['results']
    # if !character_comics.empty?
    #   character_comics.first(5).each do |character_comic|
    #     marvel_id = character_comic['id']
    #     title = character_comic['title']
    #     picture = character_comic['thumbnail']['path'] + '/standard_fantastic.' + character_comic['thumbnail']['extension']
    #     cover_picture = character_comic['thumbnail']['path'] + '/landscape_incredible.' + character_comic['thumbnail']['extension']

    #     puts "-----------------------------"
    #     puts "Creation of comic instances for #{event_character.name}'s"
    #     puts "-----------------------------"

    #     character_comic = Comic.create(marvel_id: marvel_id, name: title, picture: picture, event: marvel_event, cover_picture: cover_picture)
    #     comiccharacter = ComicCharacter.create(character: event_character, comic: character_comic)
    #   end
    # end
  end
end

puts "-----------------------------"
puts "Retrieving #{marvel_event.name}'s' comics"
puts "-----------------------------"

comics_url = event['comics']['collectionURI']
comics_url_api = "#{comics_url}?ts=1&apikey=36eb135a7d2a0fff3f10d2d9c735e032&hash=793e1ad819edff8e61c3680d8641f179"
comics_serialized = open(comics_url_api).read
comics_hash = JSON.parse(comics_serialized)
comics = comics_hash['data']['results']
if !comics.empty?
  comics.first(10).each do |comic|
    marvel_id = comic['id']
    title = comic['title']
    picture = comic['thumbnail']['path'] + '/standard_fantastic.' + comic['thumbnail']['extension']
    cover_picture = comic['thumbnail']['path'] + '/landscape_incredible.' + comic['thumbnail']['extension']

    puts "Creation of comic instances"
    new_comic = Comic.create(marvel_id: marvel_id, name: title, picture: picture, event: marvel_event, cover_picture: cover_picture)

    puts "-----------------------------"
    puts "Linking the table"
    puts "-----------------------------"

    Character.all.each do |char|
      new_comic.character_ids = new_comic.character_ids << char.id
      char.comic_ids = char.comic_ids << new_comic.id
    end


    # puts "-----------------------------"
    # puts "Retrieving #{new_comic.name}'s characters"
    # puts "-----------------------------"

    # comic_characters_url = comic['characters']['collectionURI']
    # comic_characters_url_api = "#{comic_characters_url}?ts=1&apikey=36eb135a7d2a0fff3f10d2d9c735e032&hash=793e1ad819edff8e61c3680d8641f179"
    # comic_characters_serialized = open(comic_characters_url_api).read
    # comic_characters_hash = JSON.parse(comic_characters_serialized)
    # comic_characters = comic_characters_hash['data']['results']
    # if !comic_characters.empty?
    #   comic_characters.first(5).each do |comic_character|
    #     marvel_id = comic_character['id']
    #     name = comic_character['name']
    #     picture = comic_character['thumbnail']['path'] + '/standard_fantastic.' + comic_character['thumbnail']['extension']
    #     cover_picture = comic_character['thumbnail']['path'] + '/landscape_incredible.' + comic_character['thumbnail']['extension']

    #     puts "-----------------------------"
    #     puts "Creation of character instances for #{event_comic.name}"
    #     puts "-----------------------------"

    #     comic_character = Character.create(marvel_id: marvel_id, name: name, picture: picture, event: marvel_event, cover_picture: cover_picture)
    #     comiccharacter = ComicCharacter.create(character: comic_character, comic: event_comic)
    #   end
    # end

    # puts "C'est parti"


    # character_test = Character.find_by(marvel_id: comic['id'])
    # puts my_comic
    # comiccharacter = ComicCharacter.create(character: new_character, comic: my_comic)
  end
end

puts "---------------------------------"
puts "-------------DONE----------------"
puts "---------------------------------"




# puts "Joining characters and comics"
# events.each do |event|
#   comics_url = event['comics']['collectionURI']
#   comics_url_api = "#{comics_url}?ts=1&apikey=36eb135a7d2a0fff3f10d2d9c735e032&hash=793e1ad819edff8e61c3680d8641f179"
#   comics_serialized = open(comics_url_api).read
#   comics_hash = JSON.parse(comics_serialized)
#   comics = comics_hash['data']['results']

#   comics.first(2).each do |comic|
#     comic_characters_url = comic["characters"]["collectionURI"]
#     comic_characters_url_api = "#{comic_characters_url}?ts=1&apikey=36eb135a7d2a0fff3f10d2d9c735e032&hash=793e1ad819edff8e61c3680d8641f179"
#     comic_characters_serialized = open(comic_characters_url_api).read
#     comic_characters_hash = JSON.parse(comic_characters_serialized)
#     comic_characters = comic_characters_hash['data']['results']

#     if !comic_characters.empty?
#       comic_characters.first(2).each do |c|
#         puts "look here !! "
#         puts c
#         puts c['id']
#         # puts c["name"]
#         comic_character = Character.find_by(id: c["id"])
#         puts comic_character
#         # # puts name
#         # puts "Creation of comiccharacter instances"
#         # puts character["name"]
#         # puts name
#         # comiccharacter = ComicCharacter.new(character: comic_character, comic: comic)
#         # puts comiccharacter.character
#       end
#     end
#   end

# end



