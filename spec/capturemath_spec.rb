require 'spec_helper'

describe Capturemath do
  let(:math) { '<math></math>' }

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

    it 'should return not return base64 png data that is' do
      mock_response(format)
      perform_capture.should return_math_as(format)
    end

    it_should_behave_like 'it handles server errors'
  end

end