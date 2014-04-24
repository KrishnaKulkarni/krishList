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

s1 = c1.subcats.create!(title: 'Apartments / Housing')
s2 = c1.subcats.create!(title: 'Sublets / Temporary')
s3 = c1.subcats.create!(title: 'Housing Wanted')
s4 = c3.subcats.create!(title: 'Food / Bev. / Hosp.')

ad1 = s1.ads.create!({
  title: 'For Rent! 1st Avenue and East 10th St- 3 bedroom Apartment',
  start_date: "May 01 2014",
  end_date: "May 20 2014",
  region: 'East Village',
  price: 4600,
  submitter_id: 1,
  description: 'Super cozy! 5 Min from the Subway!'
})

ad2 = s1.ads.create!({
  title: '3 Great Apartments for Rent',
  start_date: "May 21 2014",
  end_date: "May 30 2014",
  region: 'Chinatown',
  price: 1375,
  submitter_id: 2,
  description: 'Any questions or concerns, please call or text Jason at 646-662-1907'
})

ad3 = s4.ads.create!({
  title: '3 Great Apartments for Rent',
  start_date: "May 21 2014",
  end_date: "May 30 2014",
  region: 'Chinatown',
  price: 1375,
  submitter_id: 2,
  description: 'Any questions or concerns, please call or text Jason at 646-662-1907'
})

r1 = ad3.responses.create!(
   respondent_id: 1,
   title: "hey",
   body: "Maybe this will work",
   respondable_id: 1,
   respondable_type: 'AClass'
)


r2 = ad1.responses.create!(
   respondent_id: 2,
   title: "its jane",
   body: "Baby this will work",
   respondable_id: 1,
   respondable_type: 'AClass'
)