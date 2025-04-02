# frozen_string_literal: true

require 'rack/attack'

Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

Rack::Attack.throttle('req/ip', limit: 10, period: 1, &:ip)

Rack::Attack.throttle('suspicious/ip', limit: 100, period: 300) do |req|
  req.ip if req.path.start_with?('/v1')
end

Rack::Attack.blocklisted_responder = lambda do |_env|
  [403, { 'Content-Type' => 'application/json' },
   [{ message: 'Your IP has been temporarily blocked. Please try again later.' }.to_json]]
end

Rack::Attack.throttled_responder = lambda do |_env|
  [429, { 'Content-Type' => 'application/json' },
   [{ message: 'Too many requests. Please slow down.' }.to_json]]
end
