require 'nokogiri'

module Opensaz
  class HTTSession
    def initialize(xml_str)
      @xml_str = xml_str
    end

    private

    def read_time
      doc = Nokogiri::XML(@xml_str)
      doc.xpath("/Session/SessionTimers").each do |node|
        node.attribute("ClientConnected")
        node.attribute("ClientBeginRequest")
        node.attribute("GotRequestHeaders")
        node.attribute("ClientDoneRequest")
        node.attribute("GatewayTime")
        node.attribute("DNSTime")
        node.attribute("TCPConnectionTime")
        node.attribute("HTTPSHandshakeTime")
        node.attribute("ServerConnected")
        # ... too many
      end
      # return a hash
      {}
    end
  end
end