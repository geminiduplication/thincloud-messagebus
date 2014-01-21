require "helper"
require "thincloud/messagebus"

describe Thincloud::Messagebus do
  it "has a version constant" do
    version = Thincloud::Messagebus.const_get("VERSION")
    refute(version.empty?, "version must not be empty")
  end
end
