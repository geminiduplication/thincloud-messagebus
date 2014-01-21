require 'helper'
require 'thincloud/messagebus'

class TestThincloud::Messagebus < Minitest::Test

  def test_version
    version = Thincloud::Messagebus.const_get('VERSION')

    assert(!version.empty?, 'should have a VERSION constant')
  end

end
