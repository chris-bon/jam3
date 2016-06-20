require 'factory_girl_rails'

Faker::Config.locale = 'en-US'

User.create! profile_id: 1, username: 'admin', email: 'chrisbon315@gmail.com',
             password: 'Qwert1', password_confirmation: 'Qwert1'

Profile.create! user_id: 1, name: 'Chris Bon', age: 27, gender: 'Male',
                phone_number: '(650)449-6622', instruments: 'keyboard, guitar',
                genre: "trip hop, drum 'n' bass, gypsy jazz", 
                availability: 'Sun, Mon, Tue, Wed, Thu, Fri, Sat'

# Initialize User Attributes Array
names = ['name']

# Based on Afghanistan's population pyramid which typifies a youth bulge
# upload.wikimedia.org/wikipedia/commons/3/31/
#   Afghanistan_population_pyramid_2005.png
ages = []
16.times { ages += (15..19).to_a }
26.times { ages += (20..24).to_a }
23.times { ages += (25..29).to_a }
20.times { ages += (30..34).to_a }
17.times { ages += (35..39).to_a }
14.times { ages += (40..44).to_a }
12.times { ages += (45..49).to_a }
10.times { ages += (50..54).to_a }
 8.times { ages += (55..59).to_a }
 6.times { ages += (60..64).to_a }
 4.times { ages += (65..69).to_a }
 2.times { ages += (70..74).to_a }
ages += (75..80).to_a

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
(2..200).each do |n|
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

  # Generate Users and Profiles
  User.create! profile_id: n, email: email,
               username: Faker::Internet.user_name(name.split.join),
               password: 'Qwert1', password_confirmation: 'Qwert1'
  Profile.create! user_id: n, name: name, age: ages.sample,
                  gender: ['Male', 'Female'].sample,
                  phone_number: phone_number,
                  instruments: instruments_array.join(', '),
                  genre: genres_array.join(', '), availability: days.join(', ')
end

begin
  if FactoryGirl.factories.instance_variable_get(:@items).none?
    require_relative '../spec/factories'
  end
rescue NameError
end

module Thredded
  class SeedDatabase
    attr_reader :user, :users, :messageboard, :topics, :private_topics, :posts

    # SKIP_CALLBACKS = [
    #   [Thredded::Post, :commit, :after, :auto_follow_and_notify],
    #   [Thredded::PrivatePost, :commit, :after, :notify_USERS],
    # ].freeze

    def self.run users: 200, topics: 55, posts: (1..60)
      STDERR.puts 'Seeding the database...'
      # Disable callbacks to avoid creating notifications and performing unnecessary updates
      # SKIP_CALLBACKS.each { |klass, *args| klass.skip_callback *args }
      s = new
      Messageboard.transaction do s.create_messageboard
        s.create_topics        count: topics
        s.create_posts         count:  posts
        s.create_private_posts count:  posts
        # s.create_additional_messageboards
        s.log 'Running after_commit callbacks'
      end
    ensure
      # # Re-enable callbacks
      # SKIP_CALLBACKS.each { |klass, *args| klass.set_callback *args }
    end

    def log message
      STDERR.puts "- #{message}"
    end

=begin
    def create_first_user
      @user ||= User.all.first || FactoryGirl.create :user, :approved, :admin, 
                 username: 'admin', email: 'chrisbon315@gmail.com',
                 password: 'Qwert1', password_confirmation: 'Qwert1'
    end

    def create_users count:
      log "Creating #{count} USERS..."
      @users = [user] + FactoryGirl.create_list(:user, count, *(%i(approved) if rand > 0.1))
    end
=end

    def create_messageboard
      log 'Creating a messageboard...'
      @messageboard = FactoryGirl.create :messageboard, name: 'Jam Board',
                        slug: 'main-board',
                        description: 'A board is not a board without music!'
    end

    def create_additional_messageboards
      meta_group_id = MessageboardGroup.create!(name: 'Meta').id
      additional_messageboards = [
        ['General Music', 'Talk about whatever here', meta_group_id],
        ['Help, Bugs, and Suggestions',
         'Need help using the forum? Want to report a bug or make a suggestion? 
          This is the place.', meta_group_id]
      ]
      log "Creating #{additional_messageboards.length} 
           additional messageboards..."
      additional_messageboards.each do |name, description, group_id|
        messageboard = Messageboard.create! name: name, 
                                            description: description, 
                                            messageboard_group_id: group_id
        FactoryGirl.create_list :topic, 1 + rand(3), 
                                messageboard: messageboard, 
                                  with_posts: 1
      end
    end

    def create_topics count: 26, messageboard: self.messageboard
      log "Creating #{count} topics in #{messageboard.name}..."
      @topics = FactoryGirl.create_list :topic, count,
                                        messageboard: messageboard, 
                                                user: User.all.sample,
                                           last_user: User.all.sample
      @private_topics = FactoryGirl.create_list :private_topic, count,    
                               user: User.all.sample,
                          last_user: User.all.sample, 
                              users: User.all.shuffle[0..rand(User.count)]
    end

    def create_posts count: (1..30)
      log "Creating #{count} additional posts in each topic..."
      @posts = topics.flat_map do |topic|
        (count.min + rand(count.max + 1)).times do
          FactoryGirl.create :post, postable: topic, 
                                messageboard: messageboard, 
                                        user: User.all.sample
        end
      end
    end

    def create_private_posts count: (1..30)
      log "Creating #{count} additional posts in each private topic..."
      @private_posts = private_topics.flat_map do |topic|
        (count.min + rand(count.max + 1)).times do
          FactoryGirl.create :private_post, postable: topic, 
                                                user: User.all.sample
        end
      end
    end
  end
end

Thredded::SeedDatabase.run
