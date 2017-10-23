require 'socket'
require 'pry'

class Request
  attr_reader :tcp_server, :client, :request_lines
  def initialize
    @tcp_server = TCPServer.new(9292)
    @client = tcp_server.accept
    @request_lines = []
  end

  def stream
    puts "Ready for a request"
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
    binding.pry
  end

  def request
    puts "Got this request:"
    puts request_lines.inspect
  end

  def response
    puts "Sending response."
    response = "<pre>" + request_lines.join("\n") + "</pre>"
    output = "<html><head></head><body>#{response}</body></html>"
    headers = ["http/1.1 200 ok",
          "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
          "server: ruby",
          "content-type: text/html; charset=iso-8859-1",
          "content-length: #{output.length}\r\n\r\n"].join("\r\n")
    client.puts headers
    client.puts output
  end

  def close_server(headers, output)
    puts ["Wrote this response:", headers, output].join("\n")
    client.close
    puts "\nResponse complete, exiting."
  end
end

request = Request.new

request.stream
request.request
request.response
request.close_server(headers, output)
