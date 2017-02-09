require_relative '../test_helper.rb'

class PackageTest < Minitest::Test
  def setup
  end

  def test_initialize
    File.stub :read, "some data" do
      File.stub :exist?, true do
        # pkg = Opensaz::Package.new("01", {dest: "/user/home", c: "raw/1_c", s: "raw/1_s", m: "raw/1_m"})
        # assert_instance_of Opensaz::HTTPRequest, pkg.request
        # assert_instance_of Opensaz::HTTPResponse, pkg.response
        # assert_instance_of Opensaz::HTTPMiscel, pkg.miscel
      end
    end
  end
end