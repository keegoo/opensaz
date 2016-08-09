require_relative "package/http_request"
require_relative "package/http_response"
require_relative "package/http_session"

module Opensaz
  module Package
    
    attr_reader :request, :response, :miscel

    def initialize(identity, dest)
      @identity = identity
      @dest = dest
      check_files
      files = get_files

      @request = HTTPRequest.new(File.read(files[0]))
      @response = HTTPResponse.new(File.read(files[1]))
      @miscel = HTTPSession.new(File.read(files[2]))
    end

    private

    def check_files
      get_files.each{|x| raise "No such file: #{x}" unless File.exist?(x) }
    end

    def get_files
      return [
        File.join(@dest, "raw", "#{@identity}_c.txt"),
        File.join(@dest, "raw", "#{@identity}_s.txt"),
        File.join(@dest, "raw, #{@identity}_m.xml")
        ]
    end
  end
end