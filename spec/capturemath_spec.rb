require 'spec_helper'

describe Capturemath do

  #            __________
  #     - b ± √ b^2 - 4ac
  # x = -----------------
  #           2a
  #
  let(:math) { quadratic_roots }

  describe 'as_svg' do
    let(:format) { :svg }
    let(:perform_capture) { Capturemath.as_svg(math) }

    it 'should return svg data' do
      mock_response(format)
      perform_capture.should return_math_as(format)
    end

    it_should_behave_like 'it handles server errors'
  end

  describe 'as_png' do
    let(:format) { :png }
    let(:perform_capture) { Capturemath.as_png(math) }

    it 'should return Base 64 decoded png data' do
      mock_response(format)
      perform_capture.should_not return_math_as(format)
      base64_encoded(perform_capture).should return_math_as(format)
    end

    it_should_behave_like 'it handles server errors'
  end

  describe 'as_png_file' do

    before do
      mock_response(:png)
    end

    it 'should require a block' do
      -> { Capturemath.as_png_file(math) }.should raise_error(LocalJumpError)
    end

    it 'should allow access to a file within a block' do
      png_contents = nil
      Capturemath.as_png_file(math) do |png_file|
        png_contents = png_file.read
      end
      base64_encoded(png_contents).should return_math_as(:png)
    end

    it 'should unlink file when manipulating inside block' do
      file = nil
      Capturemath.as_png_file(math) do |png_file|
        file = png_file
        file.path.should_not be_nil
      end
      file.path.should be_nil
    end
  end

  describe 'config' do
    let(:config) { Capturemath.config }

    it 'should have default server' do
      config.server.should == Capturemath::DEFAULT_SERVER
    end
  end

  describe 'configure' do
    let(:new_server_location) { 'http://localhost:16000' }
    
    it 'should allow reconfiguring the server' do
      Capturemath.configure { |config|  config.server = new_server_location}
    end
  end

end