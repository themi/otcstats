require 'aws-sdk-core'
require 'net/http'
require 'uri'
require 'fileutils'

module OpsCare
  class AwsUtils
    @metadata_ip='169.254.169.254'

    class << self
      def this_instance_id
        fetch_meta_data('instance-id')
      end

      def this_region
        az = fetch_meta_data('placement/availability-zone')
        region = az[0...-1]
        region
      end

      private

      def fetch_meta_data(thing)
        begin
          http = Net::HTTP.new(@metadata_ip)
          http.read_timeout = 10
          http.open_timeout = 6
          resp = http.start() { |req| req.get("/latest/meta-data/#{thing}") }
        rescue
          # ignore errors
        end
      end
    end

    def initialize(*)
      set_aws_client
    end

    private

    def set_aws_client
      @aws_client = Concurrent::ThreadLocalVar.new( aws_client_class.new(authorise_session) )
    end

    def aws_client
      @aws_client.try(:value)
    end

    def authorise_session
      {
        region: self.class.this_region || ENV.fetch('AWS_REGION', 'ap-southeast-2'),
        credentials: Aws::InstanceProfileCredentials.new,
      }
    end

  end
end

require "ops_care/envvars"
