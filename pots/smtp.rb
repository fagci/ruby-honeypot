# frozen_string_literal: true

class SMTPPot < Pot
  def initialize
    super 25
  end

  def intro(client)
    client << "220 hello\r\n"
  end

  def respond(client, msg)
    cmd, = msg.split(/\s+/, 2)
    log msg

    case cmd.upcase
    when 'HELO'
      client << "250 hello\r\n"
    when 'DATA'
      client << "354 OK\r\n"
    when '.'
      client << "250 OK\r\n"
    when 'QUIT'
      client << "221 bye\r\n"
      raise StandardError, 'bye'
    else
      client << "250 OK\r\n"
    end
  end
end
