require 'zip'
require 'securerandom'

module Opensaz
  class Extractor
    def initialize(saz_path)
      # saz_path should be absolute path
      raise "no such file: #{saz_path}" unless File.exist?(saz_path)
      @saz = saz_path
    end

    def unzip
      Extractor.unzip(@saz, destination)
    end

    private

    def destination
      File.join(Dir.pwd, filename)
    end

    def filename
      File.basename(@saz, ".*") + "_" + SecureRandom.hex
    end

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