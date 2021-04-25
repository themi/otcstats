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
        az = fetch_meta_data('placement/')
        unless az.nil?
          region = az[0...-1]
          region
        end
      end

      private

      def fetch_meta_data(thing)
        is_dev = (ENV.fetch('RAILS_ENV', 'development') == 'development')
        begin
          http = Net::HTTP.new(@metadata_ip)
          if is_dev
            http.read_timeout = 1
            http.open_timeout = 1
          end
          resp = http.start() { |req| req.get("/latest/meta-data/#{thing}") }
puts "-----> Body: #{resp.body.inspect}"
          resp.body
        rescue => err
puts "-----> Error: #{err.message}"
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
