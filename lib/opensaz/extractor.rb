require 'zip'
require 'tmpdir'
require 'securerandom'

module Opensaz
  class Extractor
    def initialize(saz_path)
      # saz_path should be absolute path
      raise "no such file: #{saz_path}" unless File.exist?(saz_path)
      @saz = saz_path
      @dest_dir = Dir.tmpdir
    end

    def unzip
      prefix = File.basename(@saz, ".*") + "_"
      destination = File.join(@dest_dir, prefix + SecureRandom.hex)
      # return destination dir
      Extractor.unzip(@saz, destination)
    end

    def set_dest_dir(destination)
      @dest_dir = destination
    end

    private

    def self.unzip(file, destination)
      begin
        Zip::File.open(file) do |zip_file|
          zip_file.each do |f|
            fpath = File.join(destination, f.name)
            zip_file.extract(f, fpath) unless File.exist?(fpath)
          end
        end
      rescue Zip::Error => e
        raise e.message
      end
      destination
    end
  end
end