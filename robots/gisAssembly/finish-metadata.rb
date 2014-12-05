# Robot class to run under multiplexing infrastructure
module Robots       # Robot package
  module DorRepo    # Use DorRepo/SdrRepo to avoid name collision with Dor module
    module GisAssembly   # This is your workflow package name (using CamelCase)

      class FinishMetadata # This is your robot name (using CamelCase)
        # Build off the base robot implementation which implements
        # features common to all robots
        include LyberCore::Robot 

        def initialize
          super('dor', 'gisAssemblyWF', 'finish-metadata', check_queued_status: true) # init LyberCore::Robot
        end

        # `perform` is the main entry point for the robot. This is where
        # all of the robot's work is done.
        #
        # @param [String] druid -- the Druid identifier for the object to process
        def perform(druid)
          LyberCore::Log.debug "finish-metadata working on #{druid}"

          rootdir = GisRobotSuite.locate_druid_path druid, type: :stage
          
          %w{descMetadata.xml geoMetadata.xml}.each do |f|
            fn = File.join(rootdir, 'metadata', f)
            unless File.size?(fn)
              raise RuntimeError, "finish-metadata: #{druid} is missing metadata: #{f}"
            end
            LyberCore::Log.info "finish-metadata found #{fn} #{File.size(fn)} bytes"
          end

          %w{preview.jpg}.each do |f|
            fn = File.join(rootdir, 'content', f)
            unless File.size?(fn)
              raise RuntimeError, "finish-metadata: #{druid} is missing metadata content: #{f}"
            end
            LyberCore::Log.info "finish-metadata found #{fn} #{File.size(fn)} bytes"
          end
        end
      end
    end
  end
end
