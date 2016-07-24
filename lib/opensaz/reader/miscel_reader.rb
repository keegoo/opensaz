require 'nokogiri'

module Opensaz
  module Reader
    class BasicReader
      def initialize(file)
        super(file)
      end

      def to_hash
      end

      private

      def read_content
        doc = Nokogiri::XML(File.open(@file))
        # merge two hash
        # read_time(doc)
        # read_flag(doc)
      end

      private

      def read_time(doc)
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
      end

      def read_flag(doc)
        # return a hash
      end
    end
  end
end
