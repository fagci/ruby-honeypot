# frozen_string_literal: true

class HTTPPot < Pot
  def initialize
    super 80
  end

  def respond(client, msg)
    method, path, = msg.lines.first.split(/\s+/, 3)
    log "#{method} #{path}"

    link = "post_#{rand.to_s.sub('.', '')}"
    client << [
      'HTTP/1.1 200 OK',
      'Server: Apache/2.0.63 (Ubuntu)',
      'X-Powered-By: PHP/5.2.11',
      'X-Powered-By: WordPress',
      "<a href='/#{link}'>#{link}</a>"
    ].join("\r\n") + "\r\n\r\n"
  end

  def log(msg)
    puts "[#{self.class}] #{msg}"
  end
end
