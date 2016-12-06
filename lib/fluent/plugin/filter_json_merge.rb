require 'json'

module Fluent
  class JsonMergeFilter < Filter
    # Register this filter as "passthru"
    Fluent::Plugin.register_filter('json_merge', self)

    config_param :key, :string, :default => 'log'
    config_param :remove, :bool, :default => true


    def configure(conf)
      super
    end

    def start
      super
      # This is the first method to be called when it starts running
      # Use it to allocate resources, etc.
    end

    def shutdown
      super
      # This method is called when Fluentd is shutting down.
      # Use it to free up resources, etc.
    end

    def filter(tag, time, record)
      # This method implements the filtering logic for individual filters
      # It is internal to this class and called by filter_stream unless
      # the user overrides filter_stream.
      #
      # If returns nil, that record is ignored.

      if record.has_key? @key
        begin
          child = JSON.parse(record[@key])

          record.delete(@key) if @remove

          record.merge!(child)
        rescue UnparserError
          # Do nothing..
        end
      end

      return record
    end
  end
end
