require 'nokogiri'

module Opensaz
  class HTTPMiscel
    def initialize(xml_str)
      @xml = Nokogiri::XML(xml_str)
    end

    def timers
      timers_hash = {}
      @xml.xpath("/Session/SessionTimers").each do |node|
        timers_hash = {
          client_connected: node.attribute("ClientConnected").text,
          client_begin_request: node.attribute("ClientBeginRequest").text,
          got_request_headers: node.attribute("GotRequestHeaders").text,
          client_done_request: node.attribute("ClientDoneRequest").text,
          gateway_time: node.attribute("GatewayTime").text,
          dns_time: node.attribute("DNSTime").text,
          tcp_connect_time: node.attribute("TCPConnectTime").text,
          https_handshake_time: node.attribute("HTTPSHandshakeTime").text,
          server_connected: node.attribute("ServerConnected").text,
          fiddler_begin_request: node.attribute("FiddlerBeginRequest").text,
          server_got_request: node.attribute("ServerGotRequest").text,
          server_begin_response: node.attribute("ServerBeginResponse").text,
          got_response_headers: node.attribute("GotResponseHeaders").text,
          server_done_response: node.attribute("ServerDoneResponse").text,
          client_begin_response: node.attribute("ClientBeginResponse").text,
          client_done_response: node.attribute("ClientDoneResponse").text
        }
      end
      timers_hash
    end

    def flags
      flags_hash = {}
      @xml.xpath("/Session/SessionFlags/SessionFlag").each do |node|
        flags_hash.store(symbolize_it(node.attribute("N").text), node.attribute("V").text)
      end
      flags_hash
    end

    private

    def symbolize_it(str)
      # make it lower case
      # sub '-'' with '_'
      str.downcase.gsub('-', '_').to_sym
    end
  end
end