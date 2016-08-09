require_relative "package/http_request"
require_relative "package/http_response"
require_relative "package/http_session"

module Opensaz
  module Package

    def self.create(identity, dest)
      Package.check_files
      files = Package.get_files(identity, dest)

      request = HTTPRequest.new(File.read(files[0]))
      response = HTTPResponse.new(File.read(files[1]))
      miscel = HTTSession.new(File.read(files[2]))

      return request, response, miscel
    end

    private

    def self.check_files
      get_files.each{|x| raise "No such file: #{x}" unless File.exist?(x) }
    end

    def self.get_files(identity, dest)
      return [
        File.join(dest, "raw", "#{identity}_c.txt"),
        File.join(dest, "raw", "#{identity}_s.txt"),
        File.join(dest, "raw", "#{identity}_m.xml")
        ]
    end
  end
end