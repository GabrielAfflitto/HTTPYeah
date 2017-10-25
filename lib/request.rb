require 'socket'
require 'pry'
require './lib/request_hash'

class Request
  attr_reader :tcp_server, :request_lines
  def initialize
    @tcp_server = TCPServer.new(9292)
    @parser = RequestHash.new
    @request_lines = []
  end

  def accept_client
    tcp_server.accept
  end


  def request_loop
    hello_count = 0

    loop do
      client = tcp_server.accept

      request_lines = []
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end
      @parser.request_lines_select(request_lines)

      if @parser.path == "/hello"
        response = "Hello World!(#{hello_count})\n"
      elsif @parser.path == "/"
        response = "iteration 1 diagsnostic"
      else
        binding.pry
        puts response
      end


      client.print "HTTP/1.1 200 OK\r\n" +
                   "Content-Type: text/plain\r\n" +
                   "Content-Length: #{response.bytesize}\r\n" +
                   "Connection: close\r\n"
      client.print "\r\n"
      client.print response
      hello_count += 1
      client.close
    end
  end


end


if __FILE__ == $0
  request = Request.new
  request.request_loop
end

=begin
  "<html>" +
  "<headers>" +

=end
