require "active_support/concern"

##
# Module with relevant ActiveRecord event hooks to wire the Messagebus
# to AR Models. Adds an `after_commit` hook to publish all model changes.
#
# Include in a model to publish "[model]_changed" events.
#
# Example:
#   class SomeModel < ActiveRecord::Base
#     include Thincloud::Messagebus::ActiveRecord
#   end
#
module Thincloud
  module Messagebus
    module ActiveRecord
      extend ActiveSupport::Concern

      included do
        # Add `after_commit` hook for all model changes
        after_commit :publish_changes_to_thincloud_messagebus
      end

      def publish_changes_to_thincloud_messagebus
        Thincloud::Messagebus.publish :"#{ActiveModel::Naming.singular(self)}_changed",
          {
            object: self,
            previous_changes: previous_changes
          }
      end
    end # ActiveRecord
  end # Messagebus
end # Thincloud

require_relative "active_record/payload"
require_relative "active_record/subscribe_to_model"
