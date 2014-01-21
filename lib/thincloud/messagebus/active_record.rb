##
# Application event bus.  This wraps the event_bus gem for portability
# and added ability to enhance methods signatures and payloads.
#
# All of these publishers are using ActiveRecord after_commit hook and
# it's previous_changes hash which includes before and after values of
# anything that changed.  After commit only fires if the transaction was
# successful.
#
require "active_support/concern"

module Thincloud
  module Messagebus

    ##
    # include in model to define an event ("[model]_change") on all model changes
    #
    # Example:
    #
    # class EntitySelection < ActiveRecord::Base
    #   include Thincloud::Messagebus::ActiveRecord
    #
    module ActiveRecord
      extend ActiveSupport::Concern

      included do
        after_commit :publish_changes_to_thincloud_messagebus
      end

      def publish_changes_to_thincloud_messagebus
        Rails.logger.info "publish_changes #{previous_changes}"
        Thincloud::Messagebus.publish :"#{self.class.model_name.downcase}_change",
          { object: self, previous_changes: previous_changes }
      end

      ##
      # Struct and subscriber to allow an enhanced payload that is
      # smarter than your average payload about AR model changes.
      #
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
      end

    end

    ##
    # enhanced event listener for [model]_change events
    #
    # By wrapping the payload into a struct, we add some convenience
    # methods that make it easier to query the payload.
    #
    def subscribe_to_model(pattern, listener = nil, method_name = nil, &blk)
      ::EventBus.subscribe(pattern, listener = nil, method_name = nil) do |payload|
        model_payload = Thincloud::Messagebus::ActiveRecord::Payload.new(payload)
        blk.call(model_payload) if blk
      end
    end

  end
end


