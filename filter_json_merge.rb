require 'json'

module Fluent
  class DockerLogstashFilter < Filter
    # Register this filter as "passthru"
    Fluent::Plugin.register_filter('docker_logstash', self)

    # config_param works like other plugins

    def configure(conf)
      super
      # do the usual configuration here
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
      # Since our example is a pass-thru filter, it does nothing and just
      # returns the record as-is.
      # If returns nil, that records are ignored.

      log = JSON.parse(record["log"])

      record.delete("log")
      record.merge!(log)

      return record
    end
  end
end
