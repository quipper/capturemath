shared_examples_for "it handles server errors" do
  it 'raises error on timeout' do
    mock_error(format, :timeout)
    expect { perform_capture }.to raise_error(Timeout::Error)
  end

  it 'raises error on unexpected node errors' do
    mock_error(format, :unexpected_node)
    expect { perform_capture }.to raise_error(Capturemath::Error)
  end

  it 'raises error on unknown node errors' do
    mock_error(format, :unknown_node)
    expect { perform_capture }.to raise_error(Capturemath::Error)
  end

  it 'raises error when input does not have math' do
    mock_error(format, :no_math)
    expect { perform_capture }.to raise_error(Capturemath::Error, /Invalid MathML/)
  end

  it 'raises error when server is not reachable' do
    mock_error(format, :connection_refused) 
    expect { perform_capture }.to raise_error(Errno::ECONNREFUSED)
  end
end
