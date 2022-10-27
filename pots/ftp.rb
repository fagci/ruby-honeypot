# frozen_string_literal: true

class FTPPot < Pot
  def initialize
    super 21
  end

  def intro(client)
    client << "220 hello\r\n"
  end

  def respond(client, msg)
    cmd, = msg.split(/\s+/, 2)
    log msg

    case cmd.upcase
    when 'QUIT', 'CLOSE'
      client << "221 bye\r\n"
      raise StandardError, 'bye'
    else
      client << "200 OK\r\n"
    end
  end
end
