require 'pry'
class RequestRoot
  attr_reader :request_root, :request_lines
  def initialize(request_lines)
    @request_lines = request_lines
    # binding.pry
    @request_root = []
  end

  def root
    root_pre_tags.join("\n")
  end

  def root_pre_tags
    # binding.pry
    open_tag = root_format.unshift("<pre>")
    open_tag << "</pre>"
  end

  def root_format
    request_root << "Verb: #{verb}"
    request_root << "Path: #{protocol}"
    request_root << "Host: #{host}"
    request_root << "Port: #{port}"
    request_root << "Origin: #{host}"
    request_root << "Accept: #{accept}"
  end

  def split_first_item_request_lines
    request_lines[0].split
    # when recieving arguments where a method is
    # DEFINED, all argument names act like local variables
    # inside that method
    #iterate through array
  end

  def verb
    # binding.pry
    split_first_item_request_lines[0]
  end

  def path
    split_first_item_request_lines[1]
  end

  def protocol
    split_first_item_request_lines[2]
  end

  def split_second_item_request_lines
    request_lines[1].split
  end

  def host
    split_second_item_request_lines[1].split(":")[0]
  end

  def port
    split_second_item_request_lines[1].split(":")[1]
  end

  def accept
    request_lines[6].split(": ")[1]
  end

end
