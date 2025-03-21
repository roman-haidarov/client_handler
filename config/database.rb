# frozen_string_literal: true

require 'active_record'
require 'active_support'

ActiveSupport::IsolatedExecutionState.isolation_level = :fiber

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  host: ENV.fetch('DATABASE_HOST', nil),
  port: ENV.fetch('DATABASE_PORT', nil),
  username: ENV.fetch('DATABASE_USER', nil),
  password: ENV.fetch('DATABASE_PASS', nil),
  database: ENV.fetch('DATABASE_NAME', nil)
)
