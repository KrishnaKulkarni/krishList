# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
regions = %w<mnh brk que brx stn jsy lgi wch fct>

u1 = User.create!(email: 'john@example.com', password: 'password',
 username: 'Johnny')
u2 = User.create!(email: 'jane@example.com', password: 'password', username: 'Jane216')
a1 = User.create!(email: 'admin@example.com', password: 'password', username: 'Admin', is_admin: true)
users = [u1, u2, a1]


c1 = Category.create!(title: 'Housing')
c2 = Category.create!(title: 'For Sale')
c3 = Category.create!(title: 'Jobs')
categories = [c1, c2, c3]


s1 = c1.subcats.create!(title: 'Apartments / Housing')
s2 = c1.subcats.create!(title: 'Sublets / Temporary')
s3 = c1.subcats.create!(title: 'Housing Wanted')
s4 = c3.subcats.create!(title: 'Food / Bev. / Hosp.')
subcats = [s1, s2, s3, s4]

ad1 = s1.ads.new(
  title: 'For Rent! 1st Avenue and East 10th St- 3 bedroom Apartment',
  start_date: "May 01 2014",
  region: regions[0],
  price: 4600,
   description: 'Super cozy! 5 Min from the Subway!')
ad1.submitter = u1
ad1.save!

ad2 = s2.ads.new(
  title: 'New Sublet open',
  start_date: "May 21 2014",
  region: regions[1],
  price: 2100,
  description: 'Any questions or concerns, please call or text Jason at 646-662-1907')
ad2.submitter = u2
ad2.save!

ads = [ad1, ad2]



r1 = ad1.responses.new(title: "hey", body: "I like manhattan")
r1.author = a1
r1.save!

r2 = ad2.responses.new(title: "hey", body: "I wanna sublet")
r2.author = u1
r2.save!

responses = [r1, r2]

users.each do |user|
  3.times do |i|
    ad = subcats[i].ads.new(
      title: "Title #{i} from User #{user.username}",
      start_date: "Jun 01 2014",
      region: regions[i],
      price: 1500,
       description: "Description #{i}")
    ad.submitter = user
    ad.save!
    ads.push(ad)
  end
end

ads.each do |ad|
  users.each do |user|
    r = ad.responses.new(title: "R from #{user.username}", body: "I like it")
    r.author = user
    r.save!
  end
end

months = %w<Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec>
subcats.each do |subcat|
  20.times do |i|
    month = months.sample
    price = (rand * 500).to_i * 10 + 300
    ad = subcat.ads.new(
      title: "Rand Ad No. #{i}",
      start_date: "#{month} 01 2014",
      region: regions.sample,
      price: price,
      description: 'Any questions or concerns, please call or text Jason at 646-662-1907')
    ad.submitter = users.sample
    ad.save!
  end
end
