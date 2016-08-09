require_relative '../test_helper.rb'

class PackageTest < Minitest::Test
  def setup
  end

  def test_initialize
    File.stub :read, "some data" do
      Opensaz::Package.stub :check_files, "" do
        request, response, miscel = Opensaz::Package.create("01", "dest")
        assert_instance_of Opensaz::Package::HTTPRequest, request
        assert_instance_of Opensaz::Package::HTTPResponse, response
        assert_instance_of Opensaz::Package::HTTSession, miscel
      end
    end
  end
end