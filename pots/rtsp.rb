# frozen_string_literal: true

class RTSPPot < Pot
  def initialize
    super 554
  end

  def respond(client, msg)
    method, path, = msg.lines.first.split(/\s+/, 3)
    log "#{method} #{path}"

    client << [
      'RTSP/1.0 200 OK',
      'Server: MajorKernelPanic RTSP Server',
      'Cseq: 1',
      'Content-Length: 0',
      'Public: DESCRIBE,SETUP,TEARDOWN,PLAY,PAUSE'
    ].join("\r\n") + "\r\n\r\n"
  end
end
