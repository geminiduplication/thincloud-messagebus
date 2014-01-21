require "active_support/concern"

# Module with relevant ActiveRecord event hooks to wire the Messagebus
# to AR Models. Adds an `after_commit` hook to publish all model changes.
#
# Include in a model to publish "[model]_change" events.
#
# Example:
#   class SomeModel < ActiveRecord::Base
#     include Thincloud::Messagebus::ActiveRecord
#
#   end
module Thincloud
  module Messagebus
    # Enhanced event listener for model change events. Added to top-level
    # Thincloud::Messagebus module.
    def subscribe_to_model(pattern, listener = nil, method_name = nil, &blk)
      ::EventBus.subscribe(pattern, listener, method_name) do |payload|
        ar_payload = Thincloud::Messagebus::ActiveRecord::Payload
        blk.call(ar_payload.new(payload)) if blk
      end
    end

    module ActiveRecord
      extend ActiveSupport::Concern

      included do
        # Add `after_commit` hook for all model changes
        after_commit :publish_changes_to_thincloud_messagebus
      end

      def publish_changes_to_thincloud_messagebus
        event_name = "#{self.class.model_name.downcase}_change"

        Thincloud::Messagebus.publish
          :event_name,
          {
            object: self,
            previous_changes: previous_changes
          }
      end

      # "Enhanced" payload for ActiveRecord events to be used in
      # conjunction with Messagebus.subscribe_to_model.
      #
      # Original payload can be retrieved with Payload.raw
      Payload = Struct.new(:raw) do
        def model
          raw.fetch(:object)
        end

        def changes
          raw.fetch(:previous_changes){ Hash.new }
        end

        def new?
          changes["id"].present? && changes["id"][0].nil?
        end
      end # Payload
    end # ActiveRecord
  end # Messagebus
end # Thincloud
