# frozen_string_literal: true
ENV['RAILS_ENV'] = 'test'
if ENV['TRAVIS'] && !(defined?(RUBY_ENGINE) && RUBY_ENGINE == 'rbx')
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
end

require File.expand_path('../dummy/config/environment', __FILE__)

# Re-create the test database and run the migrations
db = ENV.fetch('DB', 'sqlite3')
system({ 'DB' => db }, 'script/create-db-users') unless ENV['TRAVIS']
ActiveRecord::Tasks::DatabaseTasks.drop_current
ActiveRecord::Tasks::DatabaseTasks.create_current
begin
  verbose_was = ActiveRecord::Migration.verbose
  ActiveRecord::Migration.verbose = false
  ActiveRecord::Migrator.migrate(['db/migrate/', File.join(Rails.root, 'db/migrate/')])
ensure
  ActiveRecord::Migration.verbose = verbose_was
end

require File.expand_path('../../spec/support/features/page_object/authentication', __FILE__)
require 'rspec/rails'
require 'capybara/rspec'
require 'pundit/rspec'
require 'factory_girl_rails'
require 'database_cleaner'
require 'fileutils'
require 'active_support/testing/time_helpers'

if Rails::VERSION::MAJOR >= 5
  require 'rails-controller-testing'
  # TODO: remove this configure block once rspec-rails 3.5.0 stable is released.
  RSpec.configure do |config|
    [:controller, :view, :request].each do |type|
      config.include ::Rails::Controller::Testing::TestProcess, type: type
      config.include ::Rails::Controller::Testing::TemplateAssertions, type: type
      config.include ::Rails::Controller::Testing::Integration, type: type
    end
  end
end

Dir[Rails.root.join('../../spec/support/**/*.rb')].each { |f| require f }

counter = -1

FileUtils.mkdir('log') unless File.directory?('log')
ActiveRecord::SchemaMigration.logger = ActiveRecord::Base.logger = Logger.new(File.open("log/test.#{db}.log", 'w'))

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.include FactoryGirl::Syntax::Methods
  config.include ActiveSupport::Testing::TimeHelpers

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    if Rails::VERSION::MAJOR < 5
      # after_commit testing is baked into rails 5.
      require 'test_after_commit'
      TestAfterCommit.enabled = true
    end
    ActiveJob::Base.queue_adapter = :inline
  end

  config.after(:suite) do
    counter = 0
  end

  config.before(:each) do
    DatabaseCleaner.start
    Time.zone = 'UTC'
  end

  config.after(:each) do
    DatabaseCleaner.clean
    counter += 1
    if counter > 9
      GC.enable
      GC.start
      GC.disable
      counter = 0
    end
  end
end
