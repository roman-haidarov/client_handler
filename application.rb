# frozen_string_literal: true

require 'active_record'
require 'dotenv'
require 'sinatra'
require 'sinatra/json'

Dotenv.load

require './config/database'
