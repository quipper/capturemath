# encoding: utf-8

module MockHelper
  include WebMock::API

  def quadratic_roots
    '<math display="block"><mrow><mi>x</mi><mo>=</mo><mfrac><mrow><mo>−</mo><mi>b</mi><mo>±</mo><msqrt><mrow><msup><mi>b</mi><mn>2</mn></msup><mo>−</mo><mn>4</mn><mi>a</mi><mi>c</mi></mrow></msqrt></mrow><mrow><mn>2</mn><mi>a</mi></mrow></mfrac></mrow></math>'
  end

  def mock_response(format)
    stubbed_request(format).to_return(body: load_mock(format))
  end

  def mock_error(format, error_type)
    case error_type
    when :timeout
      stubbed_request(format).to_timeout
    when :unexpected_node
      stubbed_request(format).to_return(body: "Unexpected text node")
    when :unknown_node
      stubbed_request(format).to_return(body: "Unknown node type")
    end
  end

  def load_mock(format)
    File.read(File.join(File.dirname(__FILE__), "math.#{ format }"))
  end

  RSpec::Matchers.define :return_math_as do |format|
    match do |actual|
      actual.should eq(load_mock(format))
    end

    failure_message_for_should do 
      "Expected #{format} output to be: \n\t\t#{ load_mock(format) } \nbut was: \n\t\t#{ @actual }"
    end

    failure_message_for_should_not do 
      "Expected #{format} output to NOT be: \n\t\t#{ load_mock(format) }"
    end
  end

  private 

    def stubbed_request(format)
      stub_request(:post, "#{ Capturemath.config.server }/#{ format }")
    end
end