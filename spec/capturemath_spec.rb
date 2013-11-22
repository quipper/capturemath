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
      Base64.strict_encode64(perform_capture).should return_math_as(format)
    end

    it_should_behave_like 'it handles server errors'
  end

end