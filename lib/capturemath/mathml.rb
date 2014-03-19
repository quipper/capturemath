module Capturemath
  module MathML
    def self.format(math)
      textified = math.gsub(/<math.*?>/, '&#x00A0;</mtext>').gsub(/<\/math>/, '<mtext>&#x00A0;')
      wrapped = "<math><mtext>#{textified}</mtext></math>"
      cleaned = wrapped.gsub(/<mtext>(\s|&#x00A0;)*<\/mtext>/, '')
    end
  end
end
