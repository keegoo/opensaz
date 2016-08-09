require_relative "opensaz/extractor"
require_relative "opensaz/general_info"
require_relative "opensaz/http_request"
require_relative "opensaz/http_response"
require_relative "opensaz/http_session"
require_relative "opensaz/package"
require_relative "opensaz/version"

module Opensaz
  # Your code goes here...
  def initialize(saz_path)
    @saz_path = saz_path
    @dest = nil
    @packages = nil
  end

  def basic_info
    @dest ||= Extractor.new(@saz_path).unzip
    general_file = File.join(@dest, "_index.htm")
    raise "no such file: #{general_file}" unless File.exist?(general_file)

    GeneralInfo.new(File.read(general_file)).to_a
  end

  def packages
    @dest ||= Extractor.new(@saz_path).unzip
    ids = basic_info.map{|x| x[:id]}
    ids.each do |x|
      @packages.push(Package.new(x, @dest))
    end
    @packages
  end

end
