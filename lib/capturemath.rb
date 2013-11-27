require "capturemath/version"

require 'httparty'
require 'base64'
require 'tempfile'

module Capturemath
  # The default location of Svgtex server (https://github.com/quipper/svgtex) set up by foreman. 
  DEFAULT_SERVER = 'http://localhost:16000' 

  Configuration = Struct.new(:server)
  class Error < StandardError; end

  class << self
    def as_svg(math)
      convert(math, :svg)
    end  

    def as_png(math)
      Base64.decode64(convert(math, :png))
    end

    def as_png_tempfile(math)
      png_string = as_png(math)
      png_file = Tempfile.new(["Math#{Time.now}", '.png']).tap do |file|
        file.puts png_string
        file.rewind
      end
      if block_given?
        begin
          yield(png_file)
        ensure
          png_file.close
          png_file.unlink
        end
      else
        png_file
      end
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
