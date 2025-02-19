module Thincloud
  module Messagebus
    module ActiveRecord
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
        
        def destroyed?
          model.destroyed?
        end

        def new?
          !changes["id"].nil? && changes["id"].first.nil? && !changes["id"].last.nil?
        end
      end # Payload
    end # ActiveRecord
  end # Messagebus
end # Thincloud
