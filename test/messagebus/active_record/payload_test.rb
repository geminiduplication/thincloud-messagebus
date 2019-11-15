require "helper"
require "thincloud/messagebus/active_record"

describe Thincloud::Messagebus::ActiveRecord::Payload do
  let(:mod) { Thincloud::Messagebus::ActiveRecord }
  let(:object) { 
    Objekt = Struct.new(:name) do
      def model
        name
      end
      def destroyed?
        true
      end
    end
  }
  let(:raw_payload) {
    {
      object: object.new("model"),
      previous_changes: {
        "id"   => [nil, 1],
        "name" => ["old", "new"]
      }
    }
  }

  let(:payload) { mod::Payload.new(raw_payload) }

  it "aliases object to model" do
    assert_equal(payload.model.model, "model")
  end

  it "aliases previous_changes to changes" do
    assert_equal(payload.changes, raw_payload[:previous_changes])
  end

  it "can access changed attributes" do
    assert_equal(payload.changes["name"], ["old", "new"])
  end

  it "can determine if a model was new?" do
    assert(payload.new?)
  end

  it "can determine if a model was destroyed?" do
    assert(payload.destroyed?)
  end

  it "can determine if a model is not new?" do
    payload.stub :changes, {"id" => [2, 3]} do
      refute payload.new?
    end
  end
end
