# -*- coding: utf-8 -*-
require 'capturemath/mathml'

subject = Capturemath::MathML
describe subject do

  describe '.format' do

    it 'returns blank string as blank math' do
      expect(subject.format '').to eq('<math></math>')
    end

    it 'returns simple math back' do
      expect(subject.format '<math></math>').to eq('<math></math>')
    end

    it 'wraps math-less string in math and mtext tags' do
      expect(subject.format 'text without math').to eq('<math><mtext>text without math</mtext></math>')
    end

    it 'returns wraps leading text in mtext tags' do
      expect(subject.format 'leading <math></math>').to eq('<math><mtext>leading &#x00A0;</mtext></math>')
    end

    it 'returns leading text wrapped in mtext followed by math specific tags' do
      expect(
        subject.format 'leading text<math><mi>a</mi></math>'
        ).to eq('<math><mtext>leading text&#x00A0;</mtext><mi>a</mi></math>')
    end

    it 'returns trailing text within mtext' do
      expect(
        subject.format 'leading text<math><mi>a</mi></math> trailing'
        ).to eq('<math><mtext>leading text&#x00A0;</mtext><mi>a</mi><mtext>&#x00A0; trailing</mtext></math>')
    end

    it 'works for multiple embedded math sequences' do
      expect(
        subject.format 'leading <math><mi>a</mi></math> separating <math><mi>a</mi></math> trailing'
        ).to eq('<math><mtext>leading &#x00A0;</mtext><mi>a</mi><mtext>&#x00A0; separating &#x00A0;</mtext><mi>a</mi><mtext>&#x00A0; trailing</mtext></math>')
    end

    it 'works for japanese characters' do
      expect(
        subject.format "次の式をみたす自然数<math> <mi>a</mi></math>の値の個数を求めなさい"
        ).to eq("<math><mtext>次の式をみたす自然数&#x00A0;</mtext> <mi>a</mi><mtext>&#x00A0;の値の個数を求めなさい</mtext></math>")
    end
  end
end