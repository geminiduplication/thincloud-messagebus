require "thincloud/messagebus/version"
require "event_bus"

# Application level event bus. Thin wrapper around the event_bus gem
# to provide a simple API in Thincloud applications.
module Thincloud
  module Messagebus
    extend self

    # Publish an event to the message bus.
    def publish(event, payload={})
      ::EventBus.announce(event, payload)
    end

    # Subscribe to an event on the message bus.
    def subscribe(pattern, listener = nil, method_name = nil, &blk)
      ::EventBus.subscribe(pattern, listener = nil, method_name = nil, &blk)
    end
  end # Messagebus
end # Thincloud
