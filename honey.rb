#!/usr/bin/env ruby
# frozen_string_literal: true

require 'socket'
require_relative 'pots/pot'
require_relative 'pots/http'
require_relative 'pots/rtsp'
require_relative 'pots/smtp'
require_relative 'pots/pop3'
require_relative 'pots/ftp'

pots = [HTTPPot, RTSPPot, SMTPPot, POP3Pot, FTPPot]

pots = pots.map do |pot|
  pot.new.start
end

pots.map(&:join)
