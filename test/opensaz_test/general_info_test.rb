require_relative '../test_helper.rb'

class ContainerTest < Minitest::Test
  def setup
  end

  def test_to_hash
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
    <a href="url_1">C</a>
    <a href="url_2">S</a>
    <a href="url_3">M</a>
  </td>
  <td>1</td>
  <td>/entity/id</td>
</tr>
<tr>
  <td>
    <a href="url_4">C</a>
    <a href="url_5">S</a>
    <a href="url_6">M</a>
  </td>
  <td>2</td>
  <td>/entity/name</td>
</tr>
</tbody>
EOF
    ginfo1 = Opensaz::GeneralInfo.new(str1)
    ary = ginfo1.to_hash
    assert_equal 2, ary.size
    assert_equal "2", ary[1][:id]
    assert_equal "1", ary[0][:id]
    assert_equal "/entity/name", ary[1][:url]
    assert_equal "url_1", ary[0][:c]
    assert_equal "url_2", ary[0][:s]
    assert_equal "url_3", ary[0][:m]
  end
end