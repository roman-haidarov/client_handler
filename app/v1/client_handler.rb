# frozen_string_literal: true

require_relative '../../application'

module V1
  class ClientHandler < Sinatra::Base
    get '/' do
      json message: 'Hello World'
    end
  end
end
