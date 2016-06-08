=begin
     User = { profile_id: integer,     
                username: string, email: string,
                password: string, password_confirmation: string }

  Profile = {    user_id: integer,
                    name: string,   age: integer,      gender: string,  
            phone_number: string, email: string,     location: string,   
             instruments: string, genre: string, availability: string }
=end

# Admin
User.create  profile_id: 1, 
               username: 'admin',
                  email: 'chrisbon315@gmail.com',
               password: 'Qwert1',
  password_confirmation: 'Qwert1' 

# Create Profile
Profile.create  user_id: 1,
                   name: 'Chris Bon',
                    age: 27,
                 gender: 'Male',
           phone_number: '(650) 449-6622',
               location: 'San Leandro',
            instruments: 'guitar, keyboard',
                  genre: 'jazz, trip hop, indie',
           availability: '24/7'

Faker::Config.locale = 'en-US'

# User Attributes Array Initialization
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
2.times { instruments += ['saxophone', 'violin'] }
instruments += ['clarinet', 'flute', 'trumpet', 'trombone', 'ukelele', 'bass',
                'banjo', 'sitar', 'harmonica', 'vocals', 'accordion', 'oboe',
                'other', 'cello', 'bassoon', 'bagpipe']

genres = ['alternative', 'blues', 'children', 'classical', 'country', 
          'electronica', 'euro', 'hip hop', 'holiday', 'indie', 'industrial',
          'christian', 'j-pop', 'k-pop', 'jazz', 'new age', 'opera', 'pop', 
          'r&b', 'reggae', 'rock', 'punk', 'folk', 'vocal', 'world']

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
    genre = genres_array.sample
    genres_array << genre unless genres_array.include? genre
  end

  days = ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'].shuffle[0..rand(7)]

  # Create User
  User.create  profile_id: n, 
                 username: Faker::Internet.user_name(name.split.join),
                    email: email,
                 password: 'Qwert1',
    password_confirmation: 'Qwert1' 

  # Create Profile
  Profile.create  user_id: n,
                     name: name,
                      age: ages.sample,
                   gender: ['Male', 'Female'].sample,
             phone_number: phone_number,
                    email: email,
                 location: Faker::Address.city,
              instruments: instruments_array.join(', '),
                    genre: genres_array.join(', '),
             availability: days.join(', ')
end