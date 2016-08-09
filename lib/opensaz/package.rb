module Opensaz
  class Package
    attr_reader :request, :response, :miscel
    def initialize(identity, dest)
      @identity, @dest = identity, dest
      check_files
      files = get_files

      @request = HTTPRequest.new(File.read(files[0]))
      @response = HTTPResponse.new(File.read(files[1]))
      @miscel = HTTSession.new(File.read(files[2]))
    end

    private

    def check_files
      get_files.each{|x| raise "No such file: #{x}" unless File.exist?(x) }
    end

    def get_files
      return [
        File.join(@dest, "raw", "#{@identity}_c.txt"),
        File.join(@dest, "raw", "#{@identity}_s.txt"),
        File.join(@dest, "raw", "#{@identity}_m.xml")
        ]
    end
  end
end