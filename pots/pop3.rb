# frozen_string_literal: true

class POP3Pot < Pot
  def initialize
    super 110
  end

  def intro(client)
    client << "+OK server ready\r\n"
  end

  def respond(client, msg)
    cmd, = msg.split(/\s+/, 2)
    log msg

    case cmd.upcase
    when 'STAT'
      client << "+OK 42 2048\r\n"
    when 'QUIT'
      client << "+OK bye\r\n"
      raise StandardError, 'bye'
    else
      client << "+OK ok\r\n"
    end
  end
end
