require 'pry'
class RequestRoot
  attr_accessor :request_root
  attr_reader :request_lines
  def initialize(request_lines)
    @request_lines = request_lines
    @request_root = {}
  end



  def params
    "<pre>
Verb: #{verb}
Path: #{path}
Protocol: #{protocol}
Host: #{host}
Port: #{port}
Origin: #{host}
Accept: #{accept}
</pre>"
  end

  def split_first_item_request_lines
    request_lines[0].split
  end

  def verb
    item = split_first_item_request_lines[0]
    request_root[:Verb] = item
  end

  def path
    item = split_first_item_request_lines[1]
    request_root[:Path] = item
  end

  def protocol
    item = split_first_item_request_lines[2]
    request_root[:Protocol] = item
  end

  def split_second_item_request_lines
    request_lines[1].split
  end

  def host
    item = split_second_item_request_lines[1].split(":")[0]
    request_root[:Host] = item
  end

  def port
    item = split_second_item_request_lines[1].split(":")[1]
    request_root[:Port] = item
  end

  def accept
    item = request_lines[6].split(": ")[1]
    request_root[:Accept] = item
  end

end
