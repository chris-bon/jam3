Faker::Config.locale = 'en-US'

User.create  profile_id: 1, 
               username: 'admin',
                  email: 'chrisbon315@gmail.com',
               password: 'Qwert1',
  password_confirmation: 'Qwert1' 
Profile.create  user_id: 1,
                   name: 'Chris Bon',
                    age: 27,
                 gender: 'Male',
           phone_number: '(650) 449-6622',
               location: 'San Leandro',
            instruments: 'guitar, keyboard',
                  genre: 'jazz, trip hop, indie',
           availability: '24/7'

# Initialize User Attributes Array
names = ['name']

ages = []
7.downto(2).each do |n| 
  ages += (20..(n * 10)).to_a
  ages += (15..27).to_a
  ages += (20..24).to_a
end

phone_numbers = [0]

instruments = []
8.times { instruments << 'guitar' }
6.times { instruments << 'piano' }
4.times { instruments << 'drums' }
3.times { instruments << 'bass guitar' }
2.times { instruments += ['saxophone','violin'] }
instruments += [
  'oboe','cello','flute','trumpet','bagpipe','trombone','harmonica','vocals',
  'bass','banjo','sitar','ukelele','bassoon','clarinet','accordion'
]
genres = [ 'r&b','jazz','punk','k-pop','world','reggae','new age',
           'pop','euro','rock','j-pop','indie','vocals','country',
           'opera','classical','alternative','industrial',
           'blues','christian','electronica','folk' ]
random_num_gen = [1,1,1,1,1,1,1,1,2,2,2,2,3,3,4]

# User Attribute Data Generation
(2..99).each do |n|
  # Name
  name = 'name'
  while names.include? name do
    first_name = Faker::Name.first_name
     last_name = Faker::Name.last_name
          name = "#{first_name} #{last_name}"
  end
  names << name

  email = Faker::Internet.safe_email name.split.join

  phone_number = ''
  while phone_numbers.include? phone_number do
    phone_number = ''
    7.times { phone_number += rand(10).to_s }
    phone_number.insert 3, '-'
    phone_number.insert 0, "(#{Faker::PhoneNumber.area_code}) "
  end
  phone_numbers << phone_number

  instruments_array = []
  num = random_num_gen.sample
  while instruments_array.size < num
    instrument = instruments.sample
    instruments_array << instrument unless instruments_array.include? instrument
  end

  genres_array = []
  num = random_num_gen.sample
  while genres_array.size < num
    genre = genres.sample
    genres_array << genre unless genres_array.include? genre
  end

  days = ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'].shuffle[0..rand(7)]

  # Create users
  User.create  profile_id: n, 
                 username: Faker::Internet.user_name(name.split.join),
                    email: email,
                 password: 'Qwert1',
    password_confirmation: 'Qwert1' 

  # Create profiles
  Profile.create  user_id: n,
                     name: name,
                      age: ages.sample,
                   gender: ['Male', 'Female'].sample,
             phone_number: phone_number,
              instruments: instruments_array.join(', '),
                    genre: genres_array.join(', '),
             availability: days.join(', ')
end
id = n
address = ''
latitude = Geocoder.search(address)[0].data['geometry']['location']['lat'] && longitude = Geocoder.search(address)[0].data['geometry']['location']['lng']
Location.create(profile_id: id, address: address, latitude: latitude, longitude: longitude) if latitude = Geocoder.search(address)[0].data['geometry']['location']['lat'] && longitude = Geocoder.search(address)[0].data['geometry']['location']['lng']