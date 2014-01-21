require "helper"
require "thincloud/messagebus/active_record"

describe Thincloud::Messagebus::ActiveRecord do
  let(:mod) { Thincloud::Messagebus::ActiveRecord }
  let(:bus) { Thincloud::Messagebus }

  it "adds the subscribe_to_model method to messagebus" do
    assert_respond_to(bus, :subscribe_to_model)
  end

  describe "added to a model" do
    let(:hook_method_name) { :publish_changes_to_thincloud_messagebus }
    let(:model) {
      Class.new do
        def self.after_commit_method
          @method_name
        end

        def self.after_commit(method_name)
          @method_name = method_name
        end
      end
    }

    before do
      model.send(:include, mod)
    end

    it "adds an after_commit hook" do
      assert(model.after_commit_method, hook_method_name)
    end

    it "adds the hook method" do
      assert_respond_to(model.new, hook_method_name)
    end
  end
end
