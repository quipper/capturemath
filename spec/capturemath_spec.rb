require 'spec_helper'

describe Capturemath do

  #            __________
  #     - b ± √ b^2 - 4ac
  # x = -----------------
  #           2a
  #
  let(:math) { quadratic_roots }

  describe '.as_svg' do
    let(:format) { :svg }
    let(:perform_capture) { Capturemath.as_svg(math) }

    it 'returns svg data' do
      mock_response(format)
      expect(perform_capture).to return_math_as(format)
    end

    it_should_behave_like 'it handles server errors'
  end

  describe '.as_png' do
    let(:format) { :png }
    let(:perform_capture) { Capturemath.as_png(math) }

    it 'returns Base 64 decoded png data' do
      mock_response(format)
      expect(perform_capture).to_not return_math_as(format)
      expect(base64_encoded(perform_capture)).to return_math_as(format)
    end

    it_should_behave_like 'it handles server errors'
  end

  describe '.as_png_file' do

    before do
      mock_response(:png)
    end

    it 'requires a block' do
      expect { Capturemath.as_png_file(math) }.to raise_error(LocalJumpError)
    end

    it 'allows access to a file within a block' do
      png_contents = nil
      Capturemath.as_png_file(math) do |png_file|
        png_contents = png_file.read
      end
      expect(base64_encoded(png_contents)).to return_math_as(:png)
    end

    it 'unlinks a file once done with the block' do
      file = nil
      Capturemath.as_png_file(math) do |png_file|
        file = png_file
        expect(file.path).to_not be_nil
      end
      expect(file.path).to be_nil
    end
  end

  describe '.config' do
    let(:config) { Capturemath.config }

    it 'has a default server' do
      expect(config.server).to eq(Capturemath::DEFAULT_SERVER)
    end
  end

  describe '.configure' do
    let(:new_server_location) { 'http://localhost:16000' }
    
    it 'allows reconfiguring the server' do
      Capturemath.configure { |config|  config.server = new_server_location}
      expect(Capturemath.config.server).to eq(new_server_location)
    end
  end

end