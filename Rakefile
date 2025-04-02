# frozen_string_literal: true

require 'active_record'
require 'yaml'
require 'erb'
require 'rake'

namespace :db do
  task :load_config do
    env = ENV['RACK_ENV'] || 'development'
    db_config = YAML.load(ERB.new(File.read('config/database.yml')).result)[env]
    ActiveRecord::Base.establish_connection(db_config)
  end

  desc 'Create DB'
  task create: :load_config do
    db = YAML.load(ERB.new(File.read('config/database.yml')).result)['development']['database']
    `createdb #{db}`
  end

  desc 'Migrate DB'
  task migrate: :load_config do
    ActiveRecord::MigrationContext.new('db/migrate').migrate
  end

  desc 'Rollback the last migration'
  task rollback: :load_config do
    step = ENV['STEP'] ? ENV['STEP'].to_i : 1
    ActiveRecord::MigrationContext.new('db/migrate').rollback(step)
  end

  desc 'Redo migrations (rollback and migrate again)'
  task redo: %i[rollback migrate]

  desc 'Show migration status'
  task status: :load_config do
    puts 'Migration Status:'
    ActiveRecord::MigrationContext.new('db/migrate').migrations_status.each do |status, version, name|
      puts "  #{status.ljust(8)} #{version.to_s.ljust(14)} #{name}"
    end
  end
end
