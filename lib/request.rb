require 'socket'
require 'date'
require 'pry'
require './lib/request_root'
require './lib/word_search'
require './lib/game'

class Request
  attr_reader :tcp_server, :word_search
  def initialize
    @tcp_server = TCPServer.new(9292)
  end

  def request_loop
    hello_count = 0

    loop do
      client = tcp_server.accept

      request_lines = []
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end

      headers = RequestRoot.new(request_lines)

      request_count = 0
      unless headers.path == "/favicon.ico"
        request_count += 1
      end

      if headers.path == "/hello"
        response = "Hello World!(#{hello_count})\n"
      elsif headers.path == "/"
        response = headers.params
      elsif headers.path == "/datetime"
        response = "#{Time.now.strftime('%H:%M%p on %A, %B %e, %Y')}"
      elsif headers.path == "/shutdown"
        response = "Total Requests: #{request_count}"
      elsif headers.path.include?("/word_search")
        word_search = WordSearch.new
        response = word_search.find_word(headers.path)
      elsif headers.path == "/start_game" && headers.verb == "POST"
        @game = Game.new
        response = "Good luck!"
      elsif headers.path.include?("/game") && headers.verb == "POST"
        request_lines = []
        while ( line = client.gets and !line.include?("--\r\n") )
          request_lines << line.chomp
        end
        response = @game.guess_tracker(request_lines.last.to_i)
      elsif headers.path == "/game" && headers.verb == "GET"

        response = @game.report
      else
        response = headers.params
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
