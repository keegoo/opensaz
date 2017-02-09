module Opensaz
  class Builder

    attr_reader :raw_files, :packages

    def initialize(saz_path)
      @saz_path = saz_path
      @dest = nil
      
      @raw_files = get_raw_files
      @packages = get_packages
    end

    private

    # ============================
    # return a list of hash, e.g.:
    # [{
    #   :id=>"2", 
    #   :c=>"raw/1_c.txt", 
    #   :s=>"raw/1_s.txt", 
    #   :m=>"raw/1_m.xml"
    # }, ...]
    def get_raw_files
      @dest ||= Extractor.new(@saz_path).unzip
      index_file = File.join(@dest, "_index.htm")
      raise "no such file: #{index_file}" unless File.exist?(index_file)
      GeneralInfo.new(File.read(index_file)).to_a
    end

    def get_packages
      pkgs = []
      @raw_files.each do |x|
        ahash = {
          dest: @dest,
          c: x[:c],
          s: x[:s],
          m: x[:m]
        }
        pkgs.push(Package.new(x[:id], ahash))
      end
      pkgs
    end
  end
end