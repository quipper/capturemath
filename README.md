# Capturemath

A gem that can be used to interact with a mathML to svg/png conversion server (https://github.com/quipper/svgtex). 

## Installation

In order to use the gem you would need to download and set up the svgtex server. 

Add this line to your application's Gemfile:

    gem 'capturemath', github: 'quipper/capturemath'

And then execute:

    $ bundle

## Usage

The gem assumes that the svg tex server is up and running on localhost at port 16000 (default when run using phantomjs).

If you want to change the location of the server then that can be done via the config file. 

```ruby
Capturemath.configure do |config|
  config.server = 'http://localhost:5000' 
end

######## OR ##########

Capturemath.config.server = 'http://localhost:5000'
```

If using within a rails application then put the line above in an initializer. 

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
