# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'
require 'open-uri'

Event.destroy_all
Character.destroy_all
Comic.destroy_all

puts "Fetching events api"

events_url = 'http://gateway.marvel.com/v1/public/events?ts=1&apikey=36eb135a7d2a0fff3f10d2d9c735e032&hash=793e1ad819edff8e61c3680d8641f179'
events_serialized = open(events_url).read
events_hash = JSON.parse(events_serialized)
events = events_hash['data']['results']

events.each do |event|
  puts "Retrieving data from event"
  title =  event['title']
  if event['urls'].count == 1
    wiki_link = event['urls'][0]['url']
  else
    wiki_link = event['urls'][1]['url']
  end
  start_date = event['start']
  end_date = event['end']

  puts "Creation of event instances"
  marvel_event = Event.create(name: title, wiki_link: wiki_link, start_date: start_date, end_date: end_date)
  puts marvel_event
  puts "Created event instances"


  puts "Retrieving data from characters"
  characters_url = event['characters']['collectionURI']
  characters_url_api = "#{characters_url}?ts=1&apikey=36eb135a7d2a0fff3f10d2d9c735e032&hash=793e1ad819edff8e61c3680d8641f179"
  characters_serialized = open(characters_url_api).read
  characters_hash = JSON.parse(characters_serialized)
  characters_hash
  characters = characters_hash['data']['results']

  if characters.empty?
    puts "No characters for this event"
  else
    characters.first(10).each do |character|
      puts "Retrieving data from character"
      puts name = character['name']
      puts picture = character['thumbnail']['path']

      puts "Creation of character instances"
      event_character = Character.create(name: name, picture: picture, event: marvel_event)
      puts event_character.name
      puts "Character instances created"
    end

  end



  puts "Retrieving data from comics"
  comics_url = event['comics']['collectionURI']
  comics_url_api = "#{comics_url}?ts=1&apikey=36eb135a7d2a0fff3f10d2d9c735e032&hash=793e1ad819edff8e61c3680d8641f179"
  comics_serialized = open(comics_url_api).read
  comics_hash = JSON.parse(comics_serialized)
  comics_hash
  comics = comics_hash['data']['results']
  if comics.empty?
    puts "No comics for this event"
  else
    comics.first(10).each do |comic|
      puts "Creation of comic instances"
      title = comic['title']
      picture = comic['thumbnail']['path']
      puts "Creation of comic instances"
      event_comic = Comic.create(name: title, picture: picture, event: marvel_event)
      puts event_comic.name
      puts "comic instances created"
    end
  end
end
