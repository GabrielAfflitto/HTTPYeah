require './test/test_helper'
require './lib/request'
require 'faraday'
class RequestTest < Minitest::Test

  def test_it_exists
    skip
    request = Request.new

    assert_instance_of Request, request
  end

  def test_for_headers
    # request = Request.new
    response = Faraday.get 'http://127.0.0.1:9292/'

    assert_equal "Hello World!(0)", response.body
  end

  def test_that_output_is_hello_world
    # request = Request.new

    assert_equal "", request.request_loop
  end

end
