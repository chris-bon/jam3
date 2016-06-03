=begin
     User = { profile_id: integer,     username: string, email: string,
                password: string,        password_confirmation: string }

  Profile = {    user_id: integer,         name: string,   age: integer, 
                  gender: string,  phone_number: string, email: string, 
                location: string,   instruments: string, genre: string,
            availability: string }
=end

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

num_gen = [1,1,1,1,1,1,1,1,2,2,2,2,3,3,4]

# User Attribute Data Generation
(2..999).each do |n|
  # Name
  name = 'name'
  while names.include? name do
    first_name = Faker::Name.first_name
     last_name = Faker::Name.last_name
          name = "#{first_name} #{last_name}"
  end
  names << name

  email = Faker::Internet.safe_email(name.split.join)

  phone_number = ''
  while phone_numbers.include? phone_number do
    phone_number = ''
    7.times { phone_number += rand(10).to_s }
    phone_number.insert 3, '-'
    phone_number.insert 0, "(#{Faker::PhoneNumber.area_code}) "
  end
  phone_numbers << phone_number

  user_instruments = []
  num = num_gen.sample
  while user_instruments.size < num
    instrument = instruments.sample
    user_instruments << instrument unless user_instruments.include? instrument
  end

  user_genres = []
  num = num_gen.sample
  while user_genres.size < num
    genre = genres.sample
    user_genres << genre unless user_genres.include? genre
  end

  days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'].shuffle
  availability = days[0..rand(7)]

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
              instruments: user_instruments,
                    genre: user_genres,
             availability: availability
end