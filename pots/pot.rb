# frozen_string_literal: true

require 'timeout'

class Pot
  def initialize(port)
    @port = 10_000 + port
    puts "Init #{self.class} on #{@port} for #{port}"
  end

  def start
    ::Thread.new do
      ::Socket.tcp_server_loop(@port) do |c, i|
        log "[!] New client: #{i.ip_address}"
        handle(c, i)
        log "[!] Client disconnected: #{i.ip_address}"
      end
    end
  end

  def handle(c, _i)
    intro(c) if defined? intro
    loop do
      ::Timeout.timeout(5) do
        d = c.recvfrom(1024)[0].chomp
        next if d.empty?

        respond(c, d)
      end
    rescue ::StandardError => e
      puts "[E] #{e}"
      break
    end
  end
end
