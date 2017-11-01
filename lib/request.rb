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
      @parser = RequestRoot.new(request_lines)
      # binding.pry
      request_count = 0
      unless @parser.path == "/favicon.ico"
        request_count += 1
      end

      if @parser.path == "/hello"
        response = "Hello World!(#{hello_count})\n"
      elsif @parser.path == "/"
        response = @parser.params
      elsif @parser.path == "/datetime"
        response = "#{Time.now.strftime('%H:%M%p on %A, %B %e, %Y')}"
      elsif @parser.path == "/shutdown"
        response = "Total Requests: #{request_count}"
      elsif @parser.path.include?("/word_search")
        # binding.pry
        word_search = WordSearch.new
        response = word_search.find_word(@parser.path)
      elsif @parser.path == "/start_game"
        @parser.request_root[:Verb] = "POST"
        binding.pry
        game = Game.new
        response = "Good luck!"
      elsif @parser.path.include?("/game") && @parser.verb == "POST"
        game = Game.new
        response = game.guess_tracker(@parser.path)
      elsif @parser.path == "/game" && @parser.verb == "GET"
        game = Game.new
        response = game.report
      else
        response = @parser.params
        puts response
        # binding.pry
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

    # def start_game
    #   game = Game.new
    #   puts "Good luck!"
    #   game.message
    # end
  end
end


if __FILE__ == $0
  request = Request.new
  request.request_loop
end
