require "thincloud/messagebus/version"
require "event_bus"

module Thincloud
  module Messagebus
    extend self

    ##
    # standard event publishing
    #
    def publish(event, payload={})
      ::EventBus.announce(event, payload)
    end

    ##
    # standard event listener
    #
    def subscribe(pattern, listener = nil, method_name = nil, &blk)
      ::EventBus.subscribe(pattern, listener = nil, method_name = nil, &blk)
    end

  end
end
