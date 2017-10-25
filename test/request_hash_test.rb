require './test/test_helper'
require './lib/request_hash'

class RequestHashTest < Minitest::Test

  def mock_request_lines
    ["GET / HTTP/1.1",
 "Host: 127.0.0.1:9292",
 "Connection: keep-alive",
 "Cache-Control: no-cache",
 "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36",
 "Postman-Token: 038f5866-b405-0fe9-e197-91ea96ec6d53",
 "Accept: */*",
 "Accept-Encoding: gzip, deflate, br",
 "Accept-Language: en-US,en;q=0.8"]
  end

  def test_request_lines_gives_us
    request_hash = RequestHash.new

    assert_equal "", request_hash.request_lines_select(mock_request_lines)
  end

end
