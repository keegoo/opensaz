module Opensaz
  class Reader
    def self.load_content(file_path)
      raise "file doesn't exist #{file_path}" unless File.exist?(file_path)
      File.read(file_path)
    end
  end
end