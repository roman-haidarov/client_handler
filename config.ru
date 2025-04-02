# frozen_string_literal: true

require_relative 'config/environment'
require 'sinatra'
require 'rack/attack'
require_relative 'app/v1/client_handler'

use Rack::Attack

map('/v1/client_handler') { run V1::ClientHandler }
