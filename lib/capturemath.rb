require "capturemath/version"

require 'httparty'
require 'base64'

module Capturemath
  DEFAULT_SERVER = 'http://localhost:5000'

  Configuration = Struct.new(:server)
  class Error < StandardError; end

  class << self
    def as_svg(math)
      convert(math, :svg)
    end  

    def as_png(math)
      Base64.decode64(convert(math, :png))
    end

    def config
      @config ||= Configuration.new(DEFAULT_SERVER)
    end

    def configure
      yield(config)
    end

    private 
      def convert(math, format)
        HTTParty.post("#{ config.server }/#{ format }", body: math).to_s.tap do |response|
          check_for_errors(response)
        end
      end 

      def check_for_errors(response)
        if response.match /^[Unknown node type|Unexpected.*node]/
          raise Error.new(response)
        end
      end
  end
end
