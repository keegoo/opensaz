module Opensaz
  module Reader
    class HTTPReader
      def initialize(file)
        # file should be full path
        raise "no such file: #{file}" unless File.exist?(file)
        @file = file
      end

      def to_hash
        raise "not implemented"
      end

      def read_content
        raise "not implemented" 
      end
    end
  end
end