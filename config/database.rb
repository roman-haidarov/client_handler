# frozen_string_literal: true
require 'active_record'
require 'active_support'

ActiveSupport::IsolatedExecutionState.isolation_level = :fiber

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  host: ENV['DATABASE_HOST'],
  port: ENV['DATABASE_PORT'],
  username: ENV['DATABASE_USER'],
  password: ENV['DATABASE_PASS'],
  database: ENV['DATABASE_NAME']
)
