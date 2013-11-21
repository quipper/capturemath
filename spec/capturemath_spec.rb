require 'spec_helper'

describe Capturemath do
  let(:math) { '<math></math>' }

  describe 'as_svg' do

    it 'should return svg data' do
      mock_response(:svg)
      Capturemath.as_svg(math).should return_math_as(:svg)
    end

    it 'should raise error on timeout' 
  end

  describe 'as_png' do

    it 'should return png data'

    it 'should raise error on timeout' 
  end

end