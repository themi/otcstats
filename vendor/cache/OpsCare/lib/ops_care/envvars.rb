require 'aws-sdk-ssm'

module OpsCare
  class Envvars < AwsUtils

    def all
      options = {
        filters: [
          { key: "Name", values: [envvar_key_prefix]}
        ]
      }
      params = aws_client.describe_parameters(options).parameters
      params.map do |param|
        {
          name: strip_key_prefix(param.name),
          value: get_parameter_value(param.name),
        }
      end
    end

    private

    def aws_client_class
      Aws::SSM::Client
    end

    def get_parameter_value(id)
      resp = aws_client.get_parameter({ name: id, with_decryption: true })
      resp.parameter.value
    end

    def strip_key_prefix(id)
      id.split("/").last
    end

    def envvar_key_prefix
      "/envvars/#{ENV.fetch('RAILS_ENV', 'production')}"
    end

  end
end
