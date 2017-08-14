# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

forums = ['Programla Genel', 'Genel Konular', 'Ruby Kulubü', 'Tasarım Genel', 'Oyun Genel']

forums.each do |forum |
  Forum.find_or_create_by(name: forum)
  puts "- #{forum} forumu oluşturuldu."
end
