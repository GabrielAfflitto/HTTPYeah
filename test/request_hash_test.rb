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

  def test_it_exists
    request_hash = RequestHash.new

    assert_instance_of RequestHash, request_hash
  end

  def test_for_split_verb_path_protocol
    request_hash = RequestHash.new

    assert_equal ["GET", "/", "HTTP/1.1"], request_hash.split_first_item_request_lines(mock_request_lines)
  end

  def test_for_verb
    request_hash = RequestHash.new

    assert_equal "GET", request_hash.verb
  end

  def test_for_path
    skip
    request_hash = RequestHash.new(mock_request_lines)

    assert_equal "/", request_hash.path
  end

  def test_for_protocol
    skip
    request_hash = RequestHash.new(mock_request_lines)

    assert_equal "HTTP/1.1", request_hash.protocol
  end

  def test_for_split_second_item_in_response
    skip
    request_hash = RequestHash.new(mock_request_lines)

    assert_equal ["Host:", "127.0.0.1:9292"], request_hash.split_second_item_request_lines
  end

  def test_for_host
    skip
    request_hash = RequestHash.new(mock_request_lines)

    assert_equal "127.0.0.1", request_hash.host
  end

  def test_for_port
    skip
    request_hash = RequestHash.new(mock_request_lines)

    assert_equal "9292", request_hash.port
  end

  def test_that_origin_is_the_same_as_host
    skip
    request_hash = RequestHash.new(mock_request_lines)

    assert_equal "127.0.0.1", request_hash.host
  end

  def test_for_accept
    skip
    request_hash = RequestHash.new(mock_request_lines)

    assert_equal "*/*", request_hash.accept
  end

  def test_root_format_adds_to_request_root_array
    skip
    request_hash = RequestHash.new(mock_request_lines)
    expected = ["Verb: GET", "Path: HTTP/1.1", "Host: 127.0.0.1", "Port: 9292", "Origin: 127.0.0.1", "Accept: */*"]

    assert_equal expected, request_hash.root_format
  end

  def test_root_pre_tags_returns_array_with_tags
    skip
    request_hash = RequestHash.new(mock_request_lines)
    expected = ["<pre>", "Verb: GET", "Path: HTTP/1.1", "Host: 127.0.0.1", "Port: 9292", "Origin: 127.0.0.1", "Accept: */*", "</pre>"]

    assert_equal expected, request_hash.root_pre_tags
  end

  def test_root_joins_string_by_newline
    skip
    request_hash = RequestHash.new(mock_request_lines)
    expected = "<pre>
Verb: GET
Path: HTTP/1.1
Host: 127.0.0.1
Port: 9292
Origin: 127.0.0.1
Accept: */*
</pre>"

    assert_equal expected, request_hash.root
  end

end
