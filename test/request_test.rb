require './test/test_helper'
require './lib/request'
class RequestTest < Minitest::Test
  attr_reader :request

  def setup
    @request = Request.new
  end

  def test_it_exists
    assert_instance_of Request, request
  end

  def test_for_instance_of_TCP_server
    assert_instance_of TCPServer, request.tcp_server
  end
end
