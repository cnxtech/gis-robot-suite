require 'rsolr'

# Robot class to run under multiplexing infrastructure
module Robots       # Robot package
  module DorRepo    # Use DorRepo/SdrRepo to avoid name collision with Dor module
    module GisDiscovery   # This is your workflow package name (using CamelCase)
      class LoadGeoblacklight # This is your robot name (using CamelCase)
        # Build off the base robot implementation which implements
        # features common to all robots
        include LyberCore::Robot

        def initialize
          super('dor', 'gisDiscoveryWF', 'load-geoblacklight', check_queued_status: true) # init LyberCore::Robot
        end

        # `perform` is the main entry point for the robot. This is where
        # all of the robot's work is done.
        #
        # @param [String] druid -- the Druid identifier for the object to process
        def perform(druid)
          druid = GisRobotSuite.initialize_robot druid
          LyberCore::Log.debug "load-geoblacklight working on #{druid}"

          rootdir = GisRobotSuite.locate_druid_path druid, type: :stage
          ifn = File.join(rootdir, 'metadata', 'geoblacklight.json')
          fail "load-geoblacklight: #{druid} cannot locate GeoBlacklight metadata: #{ifn}" unless File.size?(ifn)

          LyberCore::Log.debug "Indexing #{ifn}"
          record = JSON.parse(File.read(ifn))
          fail "load-geoblacklight: #{druid} cannot parse GeoBlacklight metadata: #{ifn}" if record.nil?
          url = File.join(Dor::Config.geohydra.solr.url, Dor::Config.geohydra.solr.collection)
          LyberCore::Log.debug "Connecting to #{url}"
          solr = RSolr.connect url: url
          solr.update params: { overwrite: true },
                      data: [record].to_json,
                      headers: { 'Content-Type' => 'application/json' }
          solr.commit # force commit

          LyberCore::Log.info "load-geoblacklight: #{druid} updated in #{url}"
        end
      end
    end
  end
end
