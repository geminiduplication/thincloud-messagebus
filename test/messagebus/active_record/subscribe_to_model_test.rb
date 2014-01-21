require "helper"
require "thincloud/messagebus/active_record"

describe Thincloud::Messagebus::ActiveRecord do
  let(:bus) { Thincloud::Messagebus }

  it "adds the subscribe_to_model method to messagebus" do
    assert_respond_to(bus, :subscribe_to_model)
  end
end
