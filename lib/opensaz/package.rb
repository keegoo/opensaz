module Opensaz
  class Package
    attr_reader :id, :request, :response, :miscel
    def initialize(id, ahash)
      @id = id

      requestf = File.join(ahash[:dest], ahash[:c])
      responsef = File.join(ahash[:dest], ahash[:s])

      check_files(requestf, responsef)

      @request = HTTPRequest.new(str_in_file(requestf))
      @response = HTTPResponse.new(str_in_file(responsef))
      # @miscel = HTTPMiscel.new(File.read(files[2]))
    end

    private

    def check_files(*files)
      files.each{|x| raise "No such file: #{x}" unless File.exist?(x) }
    end

    def str_in_file(file)
      # "b" is important. It won't change line endings.
      f = File.open(file, "rb")
      content = f.read
      f.close
      return content
    end
  end
end