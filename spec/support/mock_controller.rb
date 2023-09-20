class MockController
  include Authenticable
  include SubjectAuthentication
  attr_accessor :request

  def initialize
    mock_request = Struct.new(:headers)
    self.request = mock_request.new({})
  end
end
