require 'factory_girl_rails'

Faker::Config.locale = 'en-US'

User.create!(profile_id: 1, 
               username: 'admin',
                  email: 'chrisbon315@gmail.com',
               password: 'Qwert1',
  password_confirmation: 'Qwert1')

Profile.create!(user_id: 1,
                   name: 'Chris Bon',
                    age: 27,
                 gender: 'Male',
              #  location: Faker::Address.city,
           phone_number: '(650)449-6622',
            instruments: 'keyboard, guitar',
                  genre: "trip hop, drum 'n' bass",
           availability: 'Sun, Sat')

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
(2..400).each do |n|
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

  # Create USERS
  User.create!(profile_id: n, 
                 username: Faker::Internet.user_name(name.split.join),
                    email: email,
                 password: 'Qwert1',
    password_confirmation: 'Qwert1')

  # Create profiles
  Profile.create!(user_id: n,
                     name: name,
                      age: ages.sample,
                   gender: ['Male', 'Female'].sample,
                #  location: Faker::Address.city,
             phone_number: phone_number,
              instruments: instruments_array.join(', '),
                    genre: genres_array.join(', '),
             availability: days.join(', '))
end
$USERS = User.all
require 'factory_girl_rails'

# rubocop:disable HandleExceptions
begin
  if FactoryGirl.factories.instance_variable_get(:@items).none?
    require_relative '../spec/factories'
  end
rescue NameError
end
# rubocop:enable HandleExceptions

module Thredded
  class SeedDatabase
    attr_reader :user, :users, :messageboard, :topics, :private_topics, :posts

    # SKIP_CALLBACKS = [
    #   [Thredded::Post, :commit, :after, :auto_follow_and_notify],
    #   [Thredded::PrivatePost, :commit, :after, :notify_USERS],
    # ].freeze

    def self.run users: 0, topics: 55, posts: (1..60)
      # STDERR.puts 'Seeding the database...'
      # # Disable callbacks to avoid creating notifications and performing unnecessary updates
      # SKIP_CALLBACKS.each { |(klass, *args)| klass.skip_callback(*args) }
      s = new
      Messageboard.transaction do
        s.create_messageboard
        s.create_topics(count: topics)
        s.create_posts(count: posts)
        s.create_private_posts(count: posts)
        s.create_additional_messageboards
        s.log 'Running after_commit callbacks'
      end
    # ensure
    #   # Re-enable callbacks
    #   SKIP_CALLBACKS.each { |(klass, *args)| klass.set_callback(*args) }
    end

    def log(message)
      STDERR.puts "- #{message}"
    end

    # def create_first_user
    #   $USERS ||= $USER.first || FactoryGirl.create(
    #                               :user, :approved, :admin, 
    #                               name: 'Joe',
    #                               email: 'joe@example.com'
    #                             )
    # end

    # def create_users count:
    #   log "Creating #{count} USERS..."
    #   $USERS = [user] + FactoryGirl.create_list(:user, count, *(%i(approved) if rand > 0.1))
    # end

    def create_messageboard
      log 'Creating a messageboard...'
      @messageboard = FactoryGirl.create(
        :messageboard,
        name:        'Main Board',
        slug:        'main-board',
        description: 'A board is not a board without some posts'
      )
    end

    def create_additional_messageboards
      meta_group_id = MessageboardGroup.create!(name: 'Meta').id
      additional_messageboards = [
        ['Off-Topic', "Talk about whatever here, it's all good."],
        ['Help, Bugs, and Suggestions',
         'Need help using the forum? Want to report a bug or make a suggestion? This is the place.', meta_group_id],
        ['Praise', 'Want to tell us how great we are? This is the place.', meta_group_id]
      ]
      log "Creating #{additional_messageboards.length} additional messageboards..."
      additional_messageboards.each do |name, description, group_id|
        messageboard = Messageboard.create! name: name, description: description, messageboard_group_id: group_id
        FactoryGirl.create_list :topic, 1 + rand(3), messageboard: messageboard,
                                                       with_posts: 1
      end
    end

    def create_topics(count: 26, messageboard: self.messageboard)
      log "Creating #{count} topics in #{messageboard.name}..."
      @topics = FactoryGirl.create_list(
        :topic, count,
        messageboard: messageboard,
        user:         $USERS.sample,
        last_user:    $USERS.sample
      )

      @private_topics = FactoryGirl.create_list(
        :private_topic, count,
        user:      $USERS.sample,
        last_user: $USERS.sample,
        users:     $USERS.shuffle[0..rand($USERS.size)]
      )
    end

    def create_posts count: (1..30)
      log "Creating #{count} additional posts in each topic..."
      @posts = topics.flat_map do |topic|
        (count.min + rand(count.max + 1)).times do
          FactoryGirl.create(:post, postable: topic, messageboard: messageboard, user: $USERS.sample)
        end
      end
    end

    def create_private_posts count: (1..30)
      log "Creating #{count} additional posts in each private topic..."
      @private_posts = private_topics.flat_map do |topic|
        (count.min + rand(count.max + 1)).times do
          FactoryGirl.create :private_post, postable: topic, 
                                                user: $USERS.sample
        end
      end
    end
  end
end

Thredded::SeedDatabase.run
