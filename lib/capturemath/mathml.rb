module Capturemath
  module MathML
    def self.format(math)
      spacified = math.gsub(' ', '&#x00A0;')
      textified = spacified.gsub(/<math>/, '</mtext>').gsub(/<\/math>/, '<mtext>')
      wrapped = "<math><mtext>#{textified}</mtext></math>"
      cleaned = wrapped.gsub(/<mtext>\s*<\/mtext>/, '')
    end
  end
end
