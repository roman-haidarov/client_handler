# frozen_string_literal: true

require 'sinatra'
require_relative 'app/v1/client_handler'

map('/v1/client_handler') { run V1::ClientHandler }
