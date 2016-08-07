require_relative '../test_helper'

class HTTPResponseTest < Minitest::Test
  CRLF = "/r/n"

  def setup
    @str1_header = [
      "HTTP/1.1 302 Found",
      "Content-Type: text/html; charset=UTF-8",
      "Content-Length: 284",
      "Cache-Control: no-cache, must-revalidate",
      "Date: Sun, 24 Jul 2016 07:56:55 GMT",
      "Expires: Fri, 01 Jan 1990 00:00:00 GMT",
      "Location: http://cm.pos.baidu.com/gpixel?google_gid=CAESEPl21MoApz-nxb9qAaLu91Y&google_cver=1",
      "Pragma: no-cache",
      "Server: HTTP server (unknown)",
      "X-XSS-Protection: 1; mode=block",
    ]
    @str1_body =<<EOF.chomp
<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
<TITLE>302 Moved</TITLE></HEAD><BODY>
<H1>302 Moved</H1>
The document has moved
<A HREF="http://cm.pos.baidu.com/gpixel?google_gid=CAESEPl21MoApz-nxb9qAaLu91Y&amp;google_cver=1">here</A>.
</BODY></HTML>
EOF
  end

  def test_headers
    str1 = @str1_header.join(CRLF) + CRLF*2 + @str1_body
    resp1 = Opensaz::HTTPResponse.new(str1)
    assert_equal "HTTP/1.1", resp1.headers[:version]
    assert_equal "302", resp1.headers[:code]
    assert_equal "Found", resp1.headers[:status]
    assert_equal "text/html; charset=UTF-8", resp1.headers[:content_type]
    assert_equal "284", resp1.headers[:content_length]
    assert_equal "1; mode=block", resp1.headers[:x_xss_protection]
  end

  def test_body
    str1 = @str1_header.join(CRLF) + CRLF*2 + @str1_body
    resp1 = Opensaz::HTTPResponse.new(str1)
    assert_equal @str1_body, resp1.body
  end
end