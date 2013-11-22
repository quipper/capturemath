require "capturemath/version"

require 'httparty'

module Capturemath
  def self.as_svg(math)
    HTTParty.post('http://localhost:5000/svg', body: math).to_s
  end  


  class Error < StandardError; end
end
