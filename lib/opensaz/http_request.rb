module Opensaz
  class HTTPRequest

    CRLF = "\r\n"
    SEPERATOR = ": "

    def initialize(content)
      raise "request_str couldn't be nil" if content == nil
      @content = content
    end

    def headers
      first_line = headers_str.split(CRLF)[0]
      following_lines = headers_str.split(CRLF)[1..-1]
      get_request_line(first_line).merge(get_headers(following_lines))
    end

    def body
      str = @content.split(CRLF * 2)[1..-1].join(CRLF * 2)
      str == "" ? nil : str
    end

    private

    def headers_str
      @content.split(CRLF * 2)[0]
    end

    def get_request_line(str)
      # turn first line of headers into hash
      a = str.split(" ")
      {method: a[0], path: a[1], version: a[2]}
    end

    def get_headers(lines)
      # turn following lines of headers into hash
      lines.map do |x|
        a = x.split(SEPERATOR)
        [symbolize_it(a[0]), a[1]]
      end.to_h
    end

    def symbolize_it(str)
      # make it lower case
      # sub '-'' with '_'
      str.downcase.gsub('-', '_').to_sym
    end
  end
end