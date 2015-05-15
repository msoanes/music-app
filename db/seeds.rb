# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
10.times do
  email = Faker::Internet.email
  User.create!(email: email, password: 'password')
end

10.times do
  band_name = Faker::Name.name
  band = Band.create!(name: band_name)
  5.times do
    album_name = Faker::App.name
    album = band.albums.create!(
      title: album_name,
      recording_type: ['live', 'studio'].sample
    )
    10.times do
      track_name = Faker::Address.city
      album.tracks.create!(
        title: track_name,
        is_bonus: ['T', 'F'].sample
      )
    end
  end
end

tracklist = Track.all

User.all.each do |user|
  100.times do
    t = tracklist.sample
    Note.create!(track_id: t.id, user_id: user.id, notes: Faker::Hacker.say_something_smart)
  end
end
