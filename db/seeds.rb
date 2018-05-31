# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# remove after app is complete

(1..15).each do |i|
  p = Profile.new
  p.name = "name#{i}"
  p.surname = "surname#{i}"
  p.middlename = "middlename#{i}"
  p.email = "u#{i}@m.ru"
  p.age = i + 12
  p.password = '111111'
  p.save
end

p = Profile.new
p.name = "Vladimir"
p.surname = "Dedikov"
p.middlename = "Marasi"
p.email = "doc@m.ru"
p.age = 45
p.password = '111111'
p.save
p.doctor!