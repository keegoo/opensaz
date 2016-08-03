module Opensaz
  class HTTPRequest
    CRLF = "/r/n"
    SEPERATOR = ": "
    def initialize(request_str)
      @request = request_str
    end

    def headers
      first_line = headers_str.split(CRLF)[0]
      following_lines = headers_str.split(CRLF)[1..-1]
      get_request_line(first_line).merge(get_headers(following_lines))
    end

    private

    def headers_str
      @request.split(CRLF * 2)[0]
    end

    def get_request_line(str)
      # turn first line of headers into hash
      a = str.split(" ")
      {method: a[0], path: a[1], version: a[2]}
    end

    def get_headers(str)
      # turn following lines of headers into hash
      str.split(CRLF).map do |x|
        a = x.split(SEPERATOR)
        [symbolize_it(a[0]), a[1]]
      end.to_h
    end

    def symbolize_it(str)
      # make it lower case
      # sub '-'' with '_'
      str.downcase.gsub('-', '_')
    end
  end
end