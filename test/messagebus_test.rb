require "helper"
require "thincloud/messagebus"

describe Thincloud::Messagebus do
  let(:mod) { Thincloud::Messagebus }

  it "has a version constant" do
    version = mod.const_get("VERSION")
    refute(version.empty?, "version must not be empty")
  end

  it "has a publish method" do
    assert_respond_to(mod, :publish)
  end

  it "has a subscribe method" do
    assert_respond_to(mod, :subscribe)
  end

  describe "extended into a class" do
    let(:extended) { Class.new }

    before do
      extended.extend(mod)
    end

    it "has a publish method" do
      assert_respond_to(extended, :publish)
    end

    it "hsa a subsctibe method" do
      assert_respond_to(extended, :subscribe)
    end
  end
end
