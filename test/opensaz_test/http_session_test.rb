require_relative '../test_helper'

class HTTPSessionTest < Minitest::Test
  def setup
    @str1 =<<EOF
<Session SID="2" BitFlags="8">
  <SessionTimers ClientConnected="2016-07-24T15:55:45.8708013+08:00" 
                 ClientBeginRequest="2016-07-24T15:56:17.1175885+08:00" 
                 GotRequestHeaders="2016-07-24T15:56:17.1175885+08:00" 
                 ClientDoneRequest="2016-07-24T15:56:17.1175885+08:00" 
                 GatewayTime="0" 
                 DNSTime="0" 
                 TCPConnectTime="32" 
                 HTTPSHandshakeTime="0" 
                 ServerConnected="2016-07-24T15:56:17.1495903+08:00" 
                 FiddlerBeginRequest="2016-07-24T15:56:17.1495903+08:00" 
                 ServerGotRequest="2016-07-24T15:56:17.1505904+08:00" 
                 ServerBeginResponse="2016-07-24T15:56:17.4726088+08:00" 
                 GotResponseHeaders="2016-07-24T15:56:17.4726088+08:00" 
                 ServerDoneResponse="2016-07-24T15:56:17.4726088+08:00" 
                 ClientBeginResponse="2016-07-24T15:56:17.4726088+08:00" 
                 ClientDoneResponse="2016-07-24T15:56:17.4736089+08:00" />
  <PipeInfo CltReuse="true" />
  <SessionFlags>
    <SessionFlag N="x-egressport" V="51320" />
    <SessionFlag N="x-responsebodytransferlength" V="0" />
    <SessionFlag N="x-clientport" V="51004" />
    <SessionFlag N="x-clientip" V="127.0.0.1" />
    <SessionFlag N="x-hostip" V="123.125.115.164" />
    <SessionFlag N="x-processinfo" V="iexplore:6716" />
  </SessionFlags>
</Session>
EOF
  end

  def test_timers
    sss1 = Opensaz::HTTSession.new(@str1)
    assert_equal "2016-07-24T15:55:45.8708013+08:00", sss1.timers[:client_connected]
    assert_equal "32", sss1.timers[:tcp_connect_time]
    assert_equal "2016-07-24T15:56:17.4736089+08:00", sss1.timers[:client_done_response]
  end

  def test_flags
    sss1 = Opensaz::HTTSession.new(@str1)
    assert_equal "51320", sss1.flags[:x_egressport]
    assert_equal "123.125.115.164", sss1.flags[:x_hostip]
    assert_equal "iexplore:6716", sss1.flags[:x_processinfo]
  end
end