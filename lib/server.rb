# require 'socket'
# require './lib/request'
#
# request = Request.new
#
#
# headers, output = request.response
#
#   request.stream
#   request.request
#   request.response
# request_2  = Request.new
#
#   request_2.request

# require 'socket' # Provides TCPServer and TCPSocket classes
# require 'pry'
#
# server = TCPServer.new(9292)
#
# hello_count = 0
#
# loop do
#
#   client = server.accept
#
#   request = client.gets
#   response = "Hello World!(#{hello_count})\n"
#
#  # puts response
#
#   client.print "HTTP/1.1 200 OK\r\n" +
#                "Content-Type: text/plain\r\n" +
#                "Content-Length: #{response.bytesize}\r\n" +
#                "Connection: close\r\n"
#
#   client.print "\r\n"
#   client.print response
#
#   hello_count += 1
#
#   client.close
# end

require 'socket'
tcp_server = TCPServer.new(9292)
client = tcp_server.accept

puts "Ready for a request"
request_lines = []
while line = client.gets and !line.chomp.empty?
  request_lines << line.chomp
end

puts "Got this request:"
puts request_lines.inspect

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

puts ["Wrote this response:", headers, output].join("\n")
client.close
puts "\nResponse complete, exiting."
