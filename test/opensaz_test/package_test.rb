require_relative '../test_helper.rb'

class PackageTest < Minitest::Test
  def setup
  end

  def test_initialize
    pkg = Opensaz::Package.new("01", "dest")
    pkg.stub :check_files "" do
      
    end
  end
end