require_relative "opensaz/builder"
require_relative "opensaz/extractor"
require_relative "opensaz/general_info"
require_relative "opensaz/http_request"
require_relative "opensaz/http_response"
require_relative "opensaz/http_miscel"
require_relative "opensaz/package"
require_relative "opensaz/version"

#a = Opensaz.read(saz_path)
#a.basic_info[:destination]
#a.basic_info[:number_of_requests]
#a.basic_info[:hosts]
#a.packages.each{|x| puts x.duration}
#a.packages.each{|x| puts x.start_time}
#a.packages.each{|x| puts x.comments}
#a.packages.each{|x| puts x.request[:host]}
#a.packages.each{|x| puts x.response[:version]}

module Opensaz

  def self.read(saz_path)
    Builder.new(saz_path)
  end

end
