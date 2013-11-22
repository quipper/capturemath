require 'spec_helper'

describe Capturemath do
  let(:math) { '<math></math>' }

  describe 'as_svg' do

    it 'should return svg data' do
      mock_response(:svg)
      Capturemath.as_svg(math).should return_math_as(:svg)
    end

    it 'should raise error on timeout' do
      mock_error(:svg, :timeout)
      lambda { Capturemath.as_svg(math) }.should raise_error(Timeout::Error)
    end

    it 'should raise error on unexpected node errors' do
      mock_error(:svg, :unexpected_node)
      lambda { Capturemath.as_svg(math) }.should raise_error(Capturemath::Error)
    end

    it 'should raise error on unknown node errors' do
      mock_error(:svg, :unknown_node)
      lambda { Capturemath.as_svg(math) }.should raise_error(Capturemath::Error)
    end
  end

  describe 'as_png' do

    it 'should return not return base64 png data that is' do
      mock_response(:png)
      Capturemath.as_png(math).should return_math_as(:png)
    end

    it 'should raise error on timeout' 
  end

end