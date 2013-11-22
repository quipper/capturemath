
module MockHelper
  include WebMock::API

  def mock_response(format)
    stub_request(:post, "http://localhost:5000/#{ format }").to_return(body: load_mock(format))
  end

  def mock_error(format, error_type)
    case error_type
    when :timeout
      stub_request(:post, "http://localhost:5000/#{ format }").to_timeout
    when :unexpected_node
      stub_request(:post, "http://localhost:5000/#{ format }").to_return(body: "Unexpected text node")
    when :unknown_node
      stub_request(:post, "http://localhost:5000/#{ format }").to_return(body: "Unknown node type")
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
end