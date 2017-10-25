require 'pry'
class RequestHash
  attr_reader :request_items
  def initialize
    @request_items = {}
  end

  def path
    request_items[:Path]
  end

  def request_lines_select(request_lines)
    request_lines
    request_items[:Path] = request_lines[0].split[1]
    # when recieving arguments where a method is
    # DEFINED, all argument names act like local variables
    # inside that method
    #iterate through array
  end
end
