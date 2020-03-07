require "spec"

require "../src/*"
require "spectator"

# fixture load
require "./fixtures/*"

# Spectator settings
Spectator.configure do |config|
  config.fail_blank # Fail on no tests.
  config.randomize  # Randomize test order.
  config.profile    # Display slowest tests.
end
