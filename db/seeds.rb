regions = %w<mnh brk que brx stn jsy lgi wch fct>


u1 = User.create!(email: 'john@example.com', password: 'password',
 username: 'Johnny')
u2 = User.create!(email: 'jane@example.com', password: 'password', username: 'Jane216')
a1 = User.create!(email: 'admin@example.com', password: 'password', username: 'Admin', is_admin: true)
u3 = User.create!(email: 'demo@example.com', password: 'password',
 username: 'DemoUser')
users = [u1, u2, a1, u3]

categories = %w<community personals housing services jobs gigs> << "for sale"
categories.each do |cat_title|
  Category.create!(title: cat_title)
end

housing = ["apts / housing", "rooms / shared", "sublets / temporary", "housing wanted", "housing swap", "vacation rentals", "parking / storage", "office / commercial", "real estate for sale"]
h_cat = Category.includes(:subcats).find_by(title: 'housing')
housing.each do |subcat_title|
  h_cat.subcats.create!(title: subcat_title)
end

jobs = ["account+finance", "admin / office", "arch / engineering", "art / media / design", "biotech / science", "business / mgmt", "customer service", "education", "food / bev / hosp", "general labor", "government", "human resources", "internet engineers", "legal / paralegal", "manufacturing", "marketing / pr / ad", "medical / health", "nonprofit sector", "real estate", "retail / wholesale", "sales / bix dev", "salon / spa / fitness", "security", "skilled trade / craft", "software / qa / dba", "systems / network", "technical support", "transport", "tv / film / video", "web / info design", "writing / editing"]
j_cat = Category.includes(:subcats).find_by(title: 'jobs')
jobs.each do |subcat_title|
  j_cat.subcats.create!(title: subcat_title)
end

for_sale = %w<antiques baby+kid barter bikes boats books business computer free furniture general household jewelry materials rvs+camp sporting tickets tools wanted appliances arts+crafts atv/utv/sno auto_parts beauty+hlth cars+trucks
cds/dvd/vhs cell_phones clothes+acc collectibles electronics farm+garden garage_sale heavy_equip motorcycles music_instr photo+video toys+games video_gaming>
f_cat = Category.includes(:subcats).find_by(title: "for sale")
for_sale.each do |subcat_title|
  f_cat.subcats.create!(title: subcat_title)
end

services = %w<beauty creative computer cycle event financial legal lessons marine pet automotive farm+garden household labor/move therapeutic travel/vac write/ed/tr8> 
services << "skilled trade"
services << "real estate"
services << "sm biz ads"
s_cat = Category.includes(:subcats).find_by(title: "services")
services.each do |subcat_title|
  s_cat.subcats.create!(title: subcat_title)
end

gigs = %w<crew event labor talent computer creative domestic writing>
g_cat = Category.includes(:subcats).find_by(title: "gigs")
gigs.each do |subcat_title|
  g_cat.subcats.create!(title: subcat_title)
end

community = %w<activities artists childcare general groups pets events lost+found musicians politics rideshare volunteers classes>
community << "local news"
c_cat = Category.includes(:subcats).find_by(title: "community")
community.each do |subcat_title|
  c_cat.subcats.create!(title: subcat_title)
end


personals = ["strictly platonic", "women seek women", "women seeking men", "men seeking women", "men seeking men", "misc romance", "casual encounters", "missed connections", "rants and raves"]
p_cat = Category.includes(:subcats).find_by(title: "personals")
personals.each do |subcat_title|
  p_cat.subcats.create!(title: subcat_title)
end

Category.find_by(title: 'housing').option_classes.mandatory.create!(title: "rent", input_type: "number")
Category.find_by(title: 'housing').option_classes.mandatory.create!(title: "sq ft", input_type: "number")
Category.find_by(title: 'housing').option_classes.mandatory.create!(title: "available by", input_type: "date")

["apts / housing", "sublets / temporary", "housing wanted", "housing swap", "vacation rentals"].each do |subcat_title|
  Subcat.find_by(title: subcat_title).option_classes.mandatory.create!(title: "bedrooms", input_type: "number")
  Subcat.find_by(title: subcat_title).option_classes.discretionary.create!(title: "bathrooms", input_type: "number")
  Subcat.find_by(title: subcat_title).option_classes.discretionary.create!(title: "housing type", input_type: "text")
  Subcat.find_by(title: subcat_title).option_classes.discretionary.create!(title: "cats", input_type: "checkbox")
  Subcat.find_by(title: subcat_title).option_classes.discretionary.create!(title: "dogs", input_type: "checkbox")
end

Subcat.find_by(title: "rooms / shared").option_classes.discretionary.create!(title: "private room", input_type: "checkbox")
Subcat.find_by(title: "rooms / shared").option_classes.discretionary.create!(title: "private bath", input_type: "checkbox")
Subcat.find_by(title: "rooms / shared").option_classes.discretionary.create!(title: "cats", input_type: "checkbox")
Subcat.find_by(title: "rooms / shared").option_classes.discretionary.create!(title: "dogs", input_type: "checkbox")


Subcat.find_by(title: "real estate for sale").option_classes.mandatory.create!(title: "bedrooms", input_type: "number")
Subcat.find_by(title: "real estate for sale").option_classes.discretionary.create!(title: "bathrooms", input_type: "number")
Subcat.find_by(title: "real estate for sale").option_classes.discretionary.create!(title: "housing type", input_type: "text")


Category.find_by(title: "for sale").option_classes.mandatory.create!(title: "price", input_type: "number")
Subcat.find_by(title: "cars+trucks").option_classes.discretionary.create!(title: "year", input_type: "number")
Subcat.find_by(title: "cars+trucks").option_classes.discretionary.create!(title: "make / model", input_type: "text")

Subcat.find_by(title: "garage_sale").option_classes.mandatory.create!(title: "sale date", input_type: "date")

Category.find_by(title: "jobs").option_classes.discretionary.create!(title: "telecommute", input_type: "checkbox")
Category.find_by(title: "jobs").option_classes.discretionary.create!(title: "contract", input_type: "checkbox")
Category.find_by(title: "jobs").option_classes.discretionary.create!(title: "internship", input_type: "checkbox")
Category.find_by(title: "jobs").option_classes.discretionary.create!(title: "part-time", input_type: "checkbox")
Category.find_by(title: "jobs").option_classes.discretionary.create!(title: "non-profit", input_type: "checkbox")

Category.find_by(title: "personals").option_classes.discretionary.create!(title: "age", input_type: "number")
Category.find_by(title: "personals").option_classes.discretionary.create!(title: "style", input_type: "text")

subcats = Subcat.all

ad1 = Subcat.find_by(title: "sublets / temporary").ads.new(
  title: 'For Sublet! Huge Room, Low rent in Bed-Stuy!',
  region: regions[0],
  address: '780 St. Marks Ave, Brooklyn, NY',
  description: 'Super cozy! 5 Min from the Subway!')
ad1.submitter = u1
ad1.save!

ad2 =  Subcat.find_by(title: "apts / housing").ads.new(
  title: 'New Inwood Apt open',
  region: regions[1],
  address: '55 Payson, New York, NY',
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



def gen_rand_value(oc_title)
  months = %w<Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec>
  housing_types = ["apt", "duplex", "house"] 
  styles = ["rough", "tender", "sturdy", "stationary"]
  
  rand_value = {
    "rent"          => (rand * 400).to_i * 10 + 300,
    "sq ft"         => (rand * 250).to_i * 10 + 300,
    "available by"  => "#{months.sample} 01 2014",
    "bedrooms"      => (rand * 5).to_i + 1,
    "bathrooms"     => (rand * 4).to_i,
    "housing type"  => housing_types.sample,
    "cats"          => [true, false].sample,
    "dogs"          => [true, false].sample,
    "private room"  => [true, false].sample,
    "private bath"  => [true, false].sample,
    "price"         => (rand * 1000).to_i,  
    "year"          => (rand * 30).to_i + 1982,
    "telecommute"   => [true, false].sample,
    "contract"      => [true, false].sample,
    "internship"    => [true, false].sample,
    "part-time"     => [true, false].sample,
    "non-profit"    => [true, false].sample,
    "age"          => (rand * 50).to_i + 17,
    "style"        => styles.sample    
  }
  
  rand_value[oc_title]
end

rent = Category.find_by(title: "housing").option_classes.find_by(title: "rent")
Category.includes(:subcats).find_by(title: "housing").subcats.each do |subcat|
  subcat.featured_option_class1 = rent
  subcat.featured_option_class2 = subcat.option_classes.find_by(title: "bedrooms")
  subcat.featured_text = "$~ / ^BR"
  subcat.save! 
end

Category.includes(:subcats).find_by(title: "for sale").subcats.each do |subcat|
  subcat.featured_option_class1 = Category.find_by(title: "for sale").option_classes.find_by(title:"price")
  subcat.featured_text = "$~"
  subcat.save! 
end

Category.includes(:subcats).find_by(title: "jobs").subcats.each do |subcat|
  subcat.featured_option_class1 = Category.find_by(title: "jobs").option_classes.find_by(title:"part-time")
  subcat.featured_option_class2 = Category.find_by(title: "jobs").option_classes.find_by(title:"contract")
  subcat.featured_text = "Part-time: ~ / Contract:  ^"
  subcat.save! 
end

Category.includes(:subcats).find_by(title: "personals").subcats.each do |subcat|
  subcat.featured_option_class1 = Category.find_by(title: "personals").option_classes.find_by(title:"age")
  subcat.featured_option_class2 = Category.find_by(title: "personals").option_classes.find_by(title:"style")
  subcat.featured_text = "~ years young / ^"
  subcat.save! 
end


Category.includes(:subcats).find_by(title: "housing").subcats.each do |subcat|
  20.times do |i|
    ad = subcat.ads.new(
          title: "Great new place #{i}!",
          region: regions.sample,
          address: '770 Broadway, New York, NY',
          description: "Description #{i}")
        ad.submitter = User.first
        entered_options = {}
        subcat.combined_option_classes.each do |opt_class|
          entered_options[opt_class.id] = gen_rand_value(opt_class.title)
        end
        ad.entered_options = entered_options
        ad.save!
  end
end

Category.includes(:subcats).find_by(title: "personals").subcats.each do |subcat|
  20.times do |i|
    ad = subcat.ads.new(
          title: "Great new babe #{i}!",
          region: regions.sample,
          address: '770 Broadway, New York, NY',
          description: "Description #{i}")
        ad.submitter = User.first
        entered_options = {}
        subcat.combined_option_classes.each do |opt_class|
          entered_options[opt_class.id] = gen_rand_value(opt_class.title)
        end
        ad.entered_options = entered_options
        ad.save!
  end
end



# users.each do |user|
#   3.times do |i|
#     ad = subcats[i].ads.new(
#       title: "Title #{i} from User #{user.username}",
#       start_date: "Jun 01 2014",
#       region: regions[i],
#       price: 1500,
#       location: '770 Broadway, New York, NY',
#       description: "Description #{i}")
#     ad.submitter = user
#     ad.save!
#     ads.push(ad)
#   end
# end
# 
# ads.each do |ad|
#   users.each do |user|
#     r = ad.responses.new(title: "R from #{user.username}", body: "I like it")
#     r.author = user
#     r.save!
#   end
# end
# 
# months = %w<Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec>
# subcats.each do |subcat|
#   20.times do |i|
#     month = months.sample
#     price = (rand * 500).to_i * 10 + 300
#     ad = subcat.ads.new(
#       title: "Rand Ad No. #{i}",
#       start_date: "#{month} 01 2014",
#       region: regions.sample,
#       price: price,
#       location: '116th St and Broadway, New York, NY',
#       description: 'Any questions or concerns, please call or text Jason at 646-662-1907')
#     ad.submitter = users.sample
#     ad.save!
#   end
# end

# subcat = Subcat.includes(:option_classes).includes(:inherited_option_classes).find_by(title: "apts / housing")
# opt_class = subcat.inherited_option_classes.find_by(title: "rent")
# subcat.update!(featured_option_class_id1: opt_class.id)
# opt_class = subcat.option_classes.find_by(title: "bedrooms")
# subcat.update!(featured_option_class_id2: opt_class.id)
