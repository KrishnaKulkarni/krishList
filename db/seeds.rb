# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u1 = User.create!(email: 'john@example.com', password: 'password',
 username: 'Johnny')
u2 = User.create!(email: 'jane@example.com', password: 'password', username: 'Jane216')
a1 = User.create!(email: 'admin@example.com', password: 'password', username: 'Admin', is_admin: true)


c1 = Category.create!(title: 'Housing')
c2 = Category.create!(title: 'For Sale')
c3 = Category.create!(title: 'Jobs')

s1 = c1.subcats.create!(title: 'Apartments & Sublets')