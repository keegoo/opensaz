require_relative '../test_helper.rb'

class ContainerTest < Minitest::Test
  def setup
  end

  def test_to_a
    str1 =<<EOF
<thead>
<tr>
  <th>&nbsp;</th>
  <th>#</th>
  <th>url</th>
</tr>
</thead>
<tbody>
<tr>
  <td>
    <a href="raw\\1_c.txt">C</a>
    <a href="raw\\1_s.txt">S</a>
    <a href="raw\\1_m.txt">M</a>
  </td>
  <td>1</td>
  <td>/entity/id</td>
</tr>
<tr>
  <td>
    <a href="raw\\1_c.txt">C</a>
    <a href="raw\\1_s.txt">S</a>
    <a href="raw\\1_m.txt">M</a>
  </td>
  <td>2</td>
  <td>/entity/name</td>
</tr>
</tbody>
EOF
    ginfo1 = Opensaz::GeneralInfo.new(str1)
    ary = ginfo1.to_a
    assert_equal 2, ary.size
    assert_equal "2", ary[1][:id]
    assert_equal "1", ary[0][:id]
    assert_equal "raw/1_c.txt", ary[0][:c]
    assert_equal "raw/1_s.txt", ary[0][:s]
    assert_equal "raw/1_m.txt", ary[0][:m]
  end
end