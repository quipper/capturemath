require_relative '../lib/capturemath'

require 'webmock/rspec'

require 'mocks/mock_helper'
include MockHelper

require 'shared_examples'

def base64_encoded(string)
  Base64.strict_encode64(string)
end