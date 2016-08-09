require_relative "package/http_request"
require_relative "package/http_response"
require_relative "package/http_session"

module Opensaz
  module Package
    def initialize(identity)
      @identity = identity
    end
  end
end