module Opensaz
  class Builder

    attr_reader :raw_files

    def initialize(saz_path)
      @saz_path = saz_path
      @dest = nil
      
      @raw_files = get_raw_files
      #@packages = get_packages
    end

    private

    def get_raw_files
      @dest ||= Extractor.new(@saz_path).unzip
      index_file = File.join(@dest, "_index.htm")
      GeneralInfo.new(index_file).to_a
    end

    def get_packages
      @dest ||= Extractor.new(@saz_path).unzip
      ids = basic_info.map{|x| x[:id]}
      ids.each {|x| @packages.push(Package.new(x, @dest)) }
      @packages
    end
  end
end