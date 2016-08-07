require_relative "opensaz/extractor"
require_relative "opensaz/general_info"
require_relative "opensaz/http_request"
require_relative "opensaz/http_response"
require_relative "opensaz/http_session"
require_relative "opensaz/version"

module Opensaz
  # Your code goes here...
  def initialize(saz_path)
    @saz_path = saz_path
    @dest = nil
    @sessions = nil
  end

  def basic_info
    @dest ||= Extractor.new(@saz_path).unzip
    # Container.get_basic_info(@dest).to_hash
  end

  def sessions
    @dest ||= Extractor.new(@saz_path).unzip
    # Container.get_sessions(Dir.entries(File.join(@dest, "raw")))
  end

end
