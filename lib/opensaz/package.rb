module Opensaz
  class Package
    attr_reader :request, :response, :miscel
    def initialize(id, ahash)
      @id = id

      requestf = File.join(ahash[:dest], ahash[:c])
      responsef = File.join(ahash[:dest], ahash[:s])

      check_files(requestf, responsef)

      @request = HTTPRequest.new(File.read(requestf))
      @response = HTTPResponse.new(File.read(responsef))
      # @miscel = HTTPMiscel.new(File.read(files[2]))
    end

    private

    def check_files(*files)
      files.each{|x| raise "No such file: #{x}" unless File.exist?(x) }
    end
  end
end