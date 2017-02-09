module Opensaz
  class HTTPResponse < HTTPRequest
    def headers
      first_line = headers_str.split(CRLF)[0]
      following_lines = headers_str.split(CRLF)[1..-1]
      get_status_line(first_line).merge(get_headers(following_lines))
    end

    private

    def get_status_line(str)
      a = str.split(" ")
      {version: a[0], code: a[1], status: a[2]}
    end
  end
end