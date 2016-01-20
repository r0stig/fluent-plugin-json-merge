# fluentd JSON Merge Plugin

This filter plugin is intended to decode JSON in message keys and merge that data into the parent structure. The inital use-case is to decode the 1`log` field produced by the docker fluentd driver.

# Usage

By default the plugin assumes the key is `log` and that you want to delete that key:

    <filter docker.*>
      type merge_json
    </filter>

You can, however, change the key that's merged in, and retain the original value if you want:

    <filter docker.*>
      type merge_json
      key your_key
      remove false
    </filter>

# Warnings

This is a simplistic plugin which relies on ruby's hash merge: if the key you want to merge in contains a key of its own which clashes with one in the record the one in the record will be clobbered.
