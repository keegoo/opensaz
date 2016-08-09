require_relative '../test_helper'

class HTTPRequestTest < Minitest::Test
  CRLF = "/r/n"

  def setup
    @str1 = [
      "GET /html/LR/WebHelp/Content/SkinSupport/MadCapAll.js HTTP/1.1",
      "Host: claudihome.com",
      "Connection: keep-alive",
      "User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36",
      "Accept: */*",
      "Referer: http://claudihome.com/html/LR/WebHelp/Content/VuGen/121250_rec_opts_RTS_Miscellaneous.htm",
      "Accept-Encoding: gzip, deflate, sdch",
      "Accept-Language: en-US,en;q=0.8,fr;q=0.6,zh-CN;q=0.4,zh;q=0.2,zh-TW;q=0.2",
    ].join(CRLF)

    @str2 =<<EOF.chomp
<name>body</name>
EOF
  end

  def test_headers
    req1 = Opensaz::HTTPRequest.new(@str1)
    assert_equal "GET", req1.headers[:method]
    assert_equal "/html/LR/WebHelp/Content/SkinSupport/MadCapAll.js", req1.headers[:path]
    assert_equal "HTTP/1.1", req1.headers[:version]
    assert_equal "claudihome.com", req1.headers[:host]
    assert_equal "gzip, deflate, sdch", req1.headers[:accept_encoding]
    assert_equal "en-US,en;q=0.8,fr;q=0.6,zh-CN;q=0.4,zh;q=0.2,zh-TW;q=0.2", req1.headers[:accept_language]
  end

  def test_body
    req1 = Opensaz::HTTPRequest.new(@str1 + CRLF * 2 + @str2)
    assert_equal "<name>body</name>", req1.body
  end

end