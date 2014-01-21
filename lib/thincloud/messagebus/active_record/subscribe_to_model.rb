require_relative "payload"

# Enhanced event listener for model change events. Added to top-level
# Thincloud::Messagebus module.
module Thincloud
  module Messagebus
    def subscribe_to_model(pattern, listener = nil, method_name = nil, &blk)
      ::EventBus.subscribe(pattern, listener, method_name) do |payload|
        ar_payload = Thincloud::Messagebus::ActiveRecord::Payload
        blk.call(ar_payload.new(payload)) if blk
      end
    end
  end # Messagebus
end # Thincloud
