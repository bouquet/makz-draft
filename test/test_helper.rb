ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

# Setup in-memory test server for Riak
require File.expand_path('../ripple_test_helper.rb', __FILE__)

class ActiveSupport::TestCase
  teardown { Ripple::TestServer.clear }

  # Add more helper methods to be used by all tests here...
end
