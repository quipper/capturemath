require "capturemath/version"

require 'httparty'

module Capturemath
  
  class Error < StandardError; end

  def self.as_svg(math)
    HTTParty.post('http://localhost:5000/svg', body: math).to_s.tap do |response|
      check_for_errors(response)
    end
  end  

  private 

    def self.check_for_errors(response)
      if response.match /^[Unknown node type|Unexpected.*node]/
        raise Error.new(response)
      end
    end

end
