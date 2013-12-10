shared_examples_for "it handles server errors" do
  it 'should raise error on timeout' do
    mock_error(format, :timeout)
    lambda { perform_capture }.should raise_error(Timeout::Error)
  end

  it 'should raise error on unexpected node errors' do
    mock_error(format, :unexpected_node)
    lambda { perform_capture }.should raise_error(Capturemath::Error)
  end

  it 'should raise error on unknown node errors' do
    mock_error(format, :unknown_node)
    lambda { perform_capture }.should raise_error(Capturemath::Error)
  end

  it 'should raise error when input does not have math' do
    mock_error(format, :no_math)
    lambda { perform_capture }.should raise_error(Capturemath::Error, /Invalid MathML/)
  end

  it 'should raise error when server is not reachable' do
    mock_error(format, :connection_refused) 
    lambda { perform_capture }.should raise_error(Errno::ECONNREFUSED)
  end
end
