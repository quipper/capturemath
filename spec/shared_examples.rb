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
end
