# frozen_string_literal: true

require 'bundler/setup'
require 'dotenv/load'
require 'active_record'
require 'yaml'
require 'erb'
require 'groupdate'
require 'pg'
# ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
ActiveSupport::IsolatedExecutionState.isolation_level = :fiber

env = ENV['RACK_ENV'] || 'development'

db_config = YAML.load(ERB.new(File.read('config/database.yml')).result)[env]

ActiveRecord::Base.establish_connection(db_config)

Dir.glob('./config/initializers/*.rb').each { |file| require file }
