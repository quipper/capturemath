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

    it 'returns replaces spaces with mathml space entity' do
      expect(subject.format '  ').to eq('<math><mtext>&#x00A0;&#x00A0;</mtext></math>')
    end

    it 'returns wraps leading text in mtext tags' do
      expect(subject.format 'leading <math></math>').to eq('<math><mtext>leading&#x00A0;</mtext></math>')
    end

    it 'returns string without math in an array' do
      expect(subject.format 'text without math').to eq('<math><mtext>text&#x00A0;without&#x00A0;math</mtext></math>')
    end

    it 'returns math only string in an array' do
      expect(subject.format '<math></math>').to eq('<math></math>')
    end

    it 'returns leading text as different token from math' do
      expect(
        subject.format 'leading text<math><mi>a</mi></math>'
        ).to eq('<math><mtext>leading&#x00A0;text</mtext><mi>a</mi></math>')
    end

    it 'returns trailing text as different token' do
      expect(
        subject.format 'leading text<math><mi>a</mi></math> trailing'
        ).to eq('<math><mtext>leading&#x00A0;text</mtext><mi>a</mi><mtext>&#x00A0;trailing</mtext></math>')
    end

    it 'recursively partitions into tokens' do
      expect(
        subject.format 'leading <math><mi>a</mi></math> separating <math><mi>a</mi></math> trailing'
        ).to eq('<math><mtext>leading&#x00A0;</mtext><mi>a</mi><mtext>&#x00A0;separating&#x00A0;</mtext><mi>a</mi><mtext>&#x00A0;trailing</mtext></math>')
    end

    it 'works for japanese characters' do
      expect(
        subject.format "次の式をみたす自然数<math> <mi>a</mi></math>の値の個数を求めなさい"
        ).to eq("<math><mtext>次の式をみたす自然数</mtext>&#x00A0;<mi>a</mi><mtext>の値の個数を求めなさい</mtext></math>")
    end
  end
end