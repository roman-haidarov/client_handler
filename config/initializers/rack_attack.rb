# frozen_string_literal: true

require 'rack/attack'

module Rack
  class Attack
    # ✅ Rate Limiting: Limit to 10 requests per second per IP
    throttle('req/ip', limit: 10, period: 1, &:ip)

    # ✅ Fail2Ban с expo
    BAN_DURATIONS = [600, 1200, 2400, 4800, 9600].freeze
    MAX_RETRAY = 100
    BLOCK_PERIOD = 300

    blocklist('block escalating suspicious IPs') do |req|
      key = "suspicious-#{req.ip}"
      retries = Rack::Attack::Fail2Ban.count(key, period: BLOCK_PERIOD)

      if retries >= MAX_RETRAY
        ban_duration = BAN_DURATIONS[[(retries / MAX_RETRAY) - 1, BAN_DURATIONS.size - 1].min]
        Rack::Attack::Fail2Ban.filter(key, maxretry: MAX_RETRAY, findtime: BLOCK_PERIOD, bantime: ban_duration) do
          req.path.start_with?('/v1')
        end
      end
    end

    # ✅ JSON response when blocked
    self.blocklisted_response = lambda do |_|
      [403, { 'Content-Type' => 'application/json' },
       [{ message: 'Your IP has been temporarily blocked. Please try again later.' }.to_json]]
    end

    # ✅ JSON response for throttling
    self.throttled_response = lambda do |_|
      [429, { 'Content-Type' => 'application/json' }, [{ message: 'Too many requests. Please slow down.' }.to_json]]
    end
  end
end
